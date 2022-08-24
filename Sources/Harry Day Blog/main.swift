import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct HarryDay: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://harryday.xyz")!
    var name = "Harry Day"
    var description = "A collection of thoughts had by Harry Day."
    var language: Language { .english }
    var imagePath: Path? { "assets/images/socialimage.png" }
    var favicon: Favicon? { Favicon(path: "assets/images/favicon.ico", type: "image/x-icon") }
    var tagHTMLConfig: TagHTMLConfiguration? { nil }
    var twitterUsername: String? { "@HarryDayexe" }
}

// This will generate your website using the built-in Foundation theme:
try HarryDay().publish(withTheme: .hdCustom, additionalSteps: [
    .step(named: "Use Custom DateFormatter") { context in
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMMdEEEE")
        context.dateFormatter = formatter
    },
    .step(named: "Default section titles") { context in
        context.mutateAllSections { section in
            guard section.title.isEmpty else { return }
            
            switch section.id {
                case .posts:
                    section.title = "Posts"
            }
        }
    }
])

