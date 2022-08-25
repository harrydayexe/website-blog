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
            resourcePaths: ["Resources/HDCustomTheme/styles/css/styles.css"]
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
                
                Node.main(.components({
                    Div {
                        Div {
                            Div {
                                Div {
                                    Image(url: "assets/images/SongLinkrAppIcon.svg", description: "The SongLinkr app icon.")
                                }.class("section-img")
                                Div {
                                    H2("SongLinkr")
                                    Paragraph("iOS App")
                                }.class("section-title")
                            }.class("section-header")
                            
                            Paragraph("SongLinkr is a simple utility app that takes links to songs, albums and podcasts, and gives you the freedom to choose which platform you view the media on. Utilising the power of Swift and SwiftUI, SongLinkr aims to be a intuitive and natural first class citizen on iOS.")
                            
                            Div {
                                Div {
                                    Link(url: "https://songlinkr.harryday.xyz") {
                                        Paragraph("Website")
                                    }.openInNewTab()
                                }.class("button styled")
                                
                                Div {
                                    Link(url: "https://apps.apple.com/us/app/songlinkr/id1561986085") {
                                        Image(url: "assets/AppStoreBadge/BlackBadge.svg", description: "Download on the App Store")
                                    }.openInNewTab()
                                }.class("button")
                            }.class("section-buttons")
                        }.class("section-inner wrapper")
                    }.class("portfolio section")
                    
                    Div {
                        Div {
                            Div {
                                Div {
                                    Image(url: "assets/images/GentleGhostsLogo.png", description: "Gentle Ghosts Collection Logo")
                                }.class("section-img")
                                Div {
                                    H2("Gentle Ghosts")
                                    Paragraph("Procedural Pixel Art")
                                }.class("section-title")
                            }.class("section-header")
                            
                            Paragraph("Gentle Ghosts is a series of 5000 entirely unique pixel art ghosts. Each ghost was unqiuely generated from a vast array of traits to form the whole collection. The generation of each ghost was programmed using Python and downscaling was performed using NodeJS.")
                            
                            Div {
                                Div {
                                    Link(url: "https://github.com/Gentle-Ghosts/images") {
                                        Paragraph("GitHub")
                                    }.openInNewTab()
                                }.class("button styled")
                                
                                Div {
                                    Link(url: "https://apps.apple.com/us/app/songlinkr/id1561986085") {
                                        Paragraph("OpenSea")
                                    }.openInNewTab()
                                }.class("button styled")
                            }.class("section-buttons")
                        }.class("section-inner wrapper")
                    }.class("portfolio section")
                    
                    Div {
                        Div {
                            H3("The University of Manchester")
                            Paragraph("I am currently studying Computer Science at The University of Manchester which I will graduate from in 2025. During this time I will also have spent a year in industry gaining valuable experience and skills.")
                        }.class("timeline-item").attribute(named: "date-is", value: "2021-2025")
                        
                        Div {
                            H3("John Port Spencer Academy 6th Form")
                            Paragraph(html: "I completed my A Levels at John Port Spencer Academy 6th Form. During this time I studied Further Maths, Maths, Physics and Computer Science achieving A<sup>*</sup>A<sup>*</sup>A<sup>*</sup>A<sup>*</sup>. As part of the coursework for my Computer Science A Level I produced a working iOS app with a database backend and working API.")
                        }.class("timeline-item").attribute(named: "date-is", value: "2019-2021")
                        
                        Div {
                            H3("John Port Spencer Academy")
                            Paragraph("I went to high school at John Port Spencer Academy where, in the final two years, I completed my GCSE's which included Computer Science, Statistics, Engineering Manufacture and Engineering Systems Control alongside the usual core subjects. Overall I scored 9 9 9 9 9 9 9 8 7 6.")
                        }.class("timeline-item").attribute(named: "date-is", value: "2014-2019")
                    }.class("wrapper education-container")
                }))
                
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
                
                ComponentGroup(members: section.items.map( {ArticleColourSection(item: $0, context: context)} ))
                
                SiteFooter()
            }
        )
    }
    
    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body {
                SiteHeader()
                
                
                Article {
                    Link("← Back to posts", url: "/posts#\(item.path.string)").class("back-button")
                    Div {
                        Div {
                            H2(item.title)
                            Time(datetime: item.date) {
                                Text(context.dateFormatter.string(from: item.date))
                            }
                        }.class("article-header")
                        item.content.body.body
                    }.class("full-article")
                }
                .class("wrapper")
                
                SiteFooter()
            }
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
        return nil
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        return nil
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
                Link(url: "/") {
                    Image(url: "/assets/images/memoji.png", description: "Harry Day as a Memoji")
                }
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
                    Link(url: "/posts/") {
                        Paragraph("Posts")
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
                    }.openInNewTab()
                }.class("contact button styled")
            }.class("section-buttons")
        }.class("heroText")
    }
}

private struct ArticleColourSection<Site: Website>: Component {
    var item: Item<Site>
    var context: PublishingContext<Site>
    
    var body: Component {
        Article {
            Link(item.path.string)
            
            Div {
                Div {
                    Div {
                        H2(Link(item.title, url: item.path.absoluteString))
                        Paragraph(context.dateFormatter.string(from: item.date))
                    }.class("section-title")
                }.class("section-header")
                
                Paragraph(item.description)
            }.class("section-inner wrapper")
        }.class("section")
    }
}

private struct SiteFooter: Component {
    var body: Component {
        Footer {
            Div {
                Link("GitHub", url: "https://github.com/harrydayexe").openInNewTab()
                Link("LinkedIn", url: "https://linkedin.com/in/harrydayexe").openInNewTab()
                Link("Twitter", url: "https://twitter.com/harrydayexe").openInNewTab()
                Link("Contact", url: "mailto:contact@harryday.xyz").openInNewTab()
            }.class("footerContact")
            
            Node.br()
            
            Div {
                Link("Blog", url: "/posts/")
                Link("SongLinkr", url: "https://songlinkr.harryday.xyz").openInNewTab()
                Link("Gentle Ghosts", url: "https://github.com/Gentle-Ghosts/images").openInNewTab()
            }.class("footerProjects")
            
            H4("Copyright © 2022 Harry Day. All rights reserved.")
        }
    }
}

extension Component {
    func openInNewTab() -> Component {
        return self.linkTarget(.blank).linkRelationship(.noopener).linkRelationship(.noreferrer)
    }
}
