// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CashManager",
    platforms: [.iOS(.v18), .macOS(.v15)],  // Chọn phiên bản iOS tối thiểu bạn muốn hỗ trợ
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.11.0")
    ],
    targets: [
        .executableTarget(
            name: "CashManager",
            dependencies: [
                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),  // Ví dụ: Firestore
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),  // Ví dụ: Authentication
                // Thêm các product Firebase khác bạn cần ở đây
            ],
        )
        // .testTarget(
        //     name: "CashManagerTests",
        //     dependencies: ["CashManager"],
        //     path: "Tests/CashManagerTests"  // Đảm bảo đường dẫn này chính xác
        // ),
    ]
)
