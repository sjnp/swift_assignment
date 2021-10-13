@main
enum Main {
    
    static func main() async {
        @Sendable
        func listPhotos(inGallery name: String, within time: UInt64) async -> [String] {
            print("\(name) in \(time)")
            await Task.sleep(time * 1_000_000_000)  // Two seconds
            return ["IMG001", "IMG99", "IMG0404"]
        }
        let a = await listPhotos(inGallery: "hi", within: 5)
        print(a)
        let b = Task { await listPhotos(inGallery: "hello", within: 1) }
        let c = await b.value
        print(c)
    }
}