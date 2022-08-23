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
                SiteHeader()
                SiteHeroText()
                
//                AlternateColourSection {
//
//                }
                
                ArticlePreviewList(
                    items: context.allItems(
                        sortedBy: \.date,
                        order: .descending
                    ),
                    site: context.site
                )
                SiteFooter()
            }
        )
    }
    
    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body {
                SiteHeader()
                SiteHeroText()
                Wrapper {
                    H1(section.title)
                    ArticlePreviewList(items: section.items, site: context.site)
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
                    SiteHeader()
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
                SiteHeader()
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
                SiteHeader()
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
                SiteHeader()
                Wrapper {
                    H1 {
                        Text("Tagged with ")
                        Span(page.tag.string).class("tag")
                    }
                    
                    Link("Browse all tags",
                         url: context.site.tagListPath.absoluteString
                    )
                    .class("browse-all")
                    
                    ArticlePreviewList(
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


private struct SiteHeader: Component {
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

private struct SiteHeroText: Component {
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

private struct AlternateColourSection: ComponentContainer {
    @ComponentBuilder var content: ContentProvider
    
    var body: Component {
        Article {
            Div(content: content).class("section-inner wrapper")
        }.class("section")
    }
}

private struct ArticlePreviewList<Site: Website>: Component {
    var items: [Item<Site>]
    var site: Site
    
    var body: Component {
        List(items) { item in
            AlternateColourSection {
                Div {
                    H2(Link(item.title, url: item.path.absoluteString))
                }.class("section-header")
                
                Paragraph(item.description)
            }.class("section")
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
            Div {
                Link("GitHub", url: "https://github.com/harrydayexe").environmentValue(.noopener, key: .linkRelationship).environmentValue(.noreferrer, key: .linkRelationship).environmentValue(.blank, key: .linkTarget)
                Link("LinkedIn", url: "https://linkedin.com/in/harrydayexe").environmentValue(.noopener, key: .linkRelationship).environmentValue(.noreferrer, key: .linkRelationship).environmentValue(.blank, key: .linkTarget)
                Link("Twitter", url: "https://twitter.com/harrydayexe").environmentValue(.noopener, key: .linkRelationship).environmentValue(.noreferrer, key: .linkRelationship).environmentValue(.blank, key: .linkTarget)
                Link("Contact", url: "mailto:contact@harryday.xyz").environmentValue(.noopener, key: .linkRelationship).environmentValue(.noreferrer, key: .linkRelationship).environmentValue(.blank, key: .linkTarget)
            }.class("footerContact")
            
            Node.br()
            
            Div {
                Link("Blog", url: "https://harryday.xyz/blog/").environmentValue(.noopener, key: .linkRelationship).environmentValue(.noreferrer, key: .linkRelationship).environmentValue(.blank, key: .linkTarget)
                Link("SongLinkr", url: "https://songlinkr.harryday.xyz").environmentValue(.noopener, key: .linkRelationship).environmentValue(.noreferrer, key: .linkRelationship).environmentValue(.blank, key: .linkTarget)
                Link("Gentle Ghosts", url: "https://github.com/Gentle-Ghosts/images").environmentValue(.noopener, key: .linkRelationship).environmentValue(.noreferrer, key: .linkRelationship).environmentValue(.blank, key: .linkTarget)
            }.class("footerProjects")
        }
    }
}
