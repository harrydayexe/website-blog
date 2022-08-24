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
    var url = URL(string: "https://blog.harryday.xyz")!
    var name = "Harry Day"
    var description = "A collection of thoughts had by Harry Day."
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try HarryDay().publish(withTheme: .hdCustom, additionalSteps: [
    .step(named: "Use Custom DateFormatter") { context in
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMMdEEEE")
        context.dateFormatter = formatter
    }
])

