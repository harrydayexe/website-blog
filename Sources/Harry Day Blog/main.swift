import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct Temp: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
        case podcasts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://blog.harryday.xyz")!
    var name = "Harry Day"
    var description = "A collection of thoughts had by Harry Day."
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try Temp().publish(withTheme: .hdCustom)
