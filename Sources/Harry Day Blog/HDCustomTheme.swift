//
//  HDCustomTheme.swift
//  
//
//  Created by Harry Day on 09/08/2022
//  
//
//  Twitter: https://twitter.com/harrydayexe
//  Github: https://github.com/harrydayexe
//
    

import Foundation

import Plot
import Publish

public extension Theme {
    /// My custom Plot theme
    static var hdCustom: Self {
        Theme(
            htmlFactory: HDCustomHTMLFactory(),
            resourcePaths: ["Resources/HDCustomTheme/styles.css"]
        )
    }
}

private struct HDCustomHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                SiteHeroText(context: context, selectedSelectionID: nil)
                
//                Wrapper {
//                    H1(index.title)
//                    Paragraph(context.site.description)
//                        .class("description")
//                    H2("Latest content")
//                    ItemList(
//                        items: context.allItems(
//                            sortedBy: \.date,
//                            order: .descending
//                        ),
//                        site: context.site
//                    )
//                }
//                SiteFooter()
            }
        )
    }
    
    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: section.id)
                Wrapper {
                    H1(section.title)
                    ItemList(items: section.items, site: context.site)
                }
                SiteFooter()
            }
        )
    }
    
    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .components {
                    SiteHeader(context: context, selectedSelectionID: item.sectionID)
                    Wrapper {
                        Article {
                            Div(item.content.body).class("content")
                            Span("Tagged with: ")
                            ItemTagList(item: item, site: context.site)
                        }
                    }
                    SiteFooter()
                }
            )
        )
    }
    
    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper(page.body)
                SiteFooter()
            }
        )
    }
    
    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    H1("Browse all tags")
                    List(page.tags.sorted()) { tag in
                        ListItem {
                            Link(tag.string,
                                 url: context.site.path(for: tag).absoluteString
                            )
                        }
                        .class("tag")
                    }
                    .class("all-tags")
                }
                SiteFooter()
            }
        )
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    H1 {
                        Text("Tagged with ")
                        Span(page.tag.string).class("tag")
                    }
                    
                    Link("Browse all tags",
                         url: context.site.tagListPath.absoluteString
                    )
                    .class("browse-all")
                    
                    ItemList(
                        items: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        site: context.site
                    )
                }
                SiteFooter()
            }
        )
    }
}

private struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider
    
    var body: Component {
        Div(content: content).class("wrapper")
    }
}

private struct SiteHeader<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?
    
    var body: Component {
        Header {
            Div {
                Image(url: "https://harryday.xyz/assets/images/memoji.png", description: "Harry Day as a Memoji")
            }.class("header-icon")
            
            
            Div {
                H1(html: "Harry<br>Day<span>{}</span>")
                Paragraph("@harrydayexe everywhere")
            }.class("header-info")
        }
    }
}

private struct SiteHeroText<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?
    
    var body: Component {
        Wrapper {
            H2("Computer Science Undergraduate")
            Paragraph("Hi, my name is Harry Day and I am currently studying Computer Science at The University of Manchester. I have a passion for programming and problem solving. Outside of work you can normally find me weight-lifting or watching Formula 1. Check out some of my past and present projects below.")
            
            Div {
                Div {
                    Link(url: "https://harryday.xyz/blog/") {
                        Paragraph("Blog")
                    }
                }.class("contact button styled")
                
                Div {
                    Link(url: "mailto:contact@harryday.xyz") {
                        Paragraph("Contact")
                    }
                }.class("contact button styled")
                
                Div {
                    Link(url: "https://github.com/harrydayexe") {
                        Paragraph("My GitHub")
                    }
                    .environmentValue(.noopener, key: .linkRelationship)
                    .environmentValue(.noreferrer, key: .linkRelationship)
                    .environmentValue(.blank, key: .linkTarget)
                }.class("contact button styled")
            }.class("section-buttons")
        }.class("heroText")
    }
}

private struct ItemList<Site: Website>: Component {
    var items: [Item<Site>]
    var site: Site
    
    var body: Component {
        List(items) { item in
            Article {
                H1(Link(item.title, url: item.path.absoluteString))
                ItemTagList(item: item, site: site)
                Paragraph(item.description)
            }
        }
        .class("item-list")
    }
}

private struct ItemTagList<Site: Website>: Component {
    var item: Item<Site>
    var site: Site
    
    var body: Component {
        List(item.tags) { tag in
            Link(tag.string, url: site.path(for: tag).absoluteString)
        }
        .class("tag-list")
    }
}

private struct SiteFooter: Component {
    var body: Component {
        Footer {
            Paragraph {
                Text("Generated using ")
                Link("Publish", url: "https://github.com/johnsundell/publish")
            }
            Paragraph {
                Link("RSS feed", url: "/feed.rss")
            }
        }
    }
}
