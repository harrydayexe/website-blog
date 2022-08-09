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
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        <#code#>
    }
    
    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        <#code#>
    }
    
    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        <#code#>
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        <#code#>
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        <#code#>
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        <#code#>
    }    
}
