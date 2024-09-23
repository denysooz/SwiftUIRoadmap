//
//  Lesson1View.swift
//  SwiftUIRoadmap
//
//  Created by Denis Dareuskiy on 22.09.24.
//

import SwiftUI

struct MenuSection {
    var items: [MenuItemType] = []
}

enum MenuItemType {
    case wishlist
    case download
    case theme(Bool)
    case language
    case logout
    case privacy
    case version(String)
}

final class Lesson1ViewModel: ObservableObject {
    @Published var menuSections: [MenuSection] = []
    
    init() {
        let firstSection = MenuSection(items: [.wishlist, .download])
        
        let secondSection = MenuSection(items: [.theme(true), .language])
        
        let thirdSection = MenuSection(items: [.logout, .privacy, .version("1.2.54b")])
        
        menuSections = [firstSection, secondSection, thirdSection]
    }
}

struct Lesson1View: View {
    
    @StateObject private var viewModel = Lesson1ViewModel()
    
    var body: some View {
        VStack {
            menu
        }
    }
    
}

// MARK: - Menu

private extension Lesson1View {
    
    var menu: some View {
        VStack(spacing: 0) {
            LazyVStack {
                ForEach(0..<viewModel.menuSections.count, id: \.self) { index in
                    menuSectionItems(section: viewModel.menuSections[index])
                }
            }
        }
    }
}
// MARK: - Menu items sections

private extension Lesson1View {
    func menuSectionItems(section: MenuSection) -> some View {
        LazyVStack(spacing: 0) {
            ForEach(0..<section.items.count, id: \.self) { index in
                let menuItem = section.items[index]
                let showDivider = (index != (section.items.count - 1))

                switch menuItem {
                case .wishlist: getWishlistCell(showDivider: showDivider)
                case .download: Text("Скачать")
                case .theme(let isEnabled): Text("Тема \(isEnabled ? "включена" : "выключена")")
                case .language: Text("Язык")
                case .logout: Text("Выйти")
                case .privacy: Text("Конфиденциальность")
                case .version(let name): Text("Версия: \(name)")
                }
            }
        }
    }
}

// MARK: - Whishlist cell

private extension Lesson1View {
    func getWishlistCell(showDivider: Bool) -> some View {
        HStack {
            Image("heart")
                .resizable()
                .frame(width: 20, height: 17)
                .foregroundStyle(.gray)
            
            Text("Whishlist")
                .font(.caption2)
        }
    }
}

#Preview {
    Lesson1View()
}
