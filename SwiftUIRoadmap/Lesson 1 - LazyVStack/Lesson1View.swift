//
//  Lesson1View.swift
//  SwiftUIRoadmap
//
//  Created by Denis Dareuskiy on 22.09.24.
//

import SwiftUI

struct MenuSection {
    let type: MenuSectionType
    var items: [MenuItemType]
}

enum MenuSectionType {
    case media
    case preferences
    case account
    
    var title: String {
        switch self {
        case .media: return "Media"
        case .preferences: return "Preferences"
        case .account: return "Account"
        }
    }
}

enum MenuItemType {
    case wishlist
    case theme(Bool)
    case download
    case language
    case logout
    case privacy
    case version(String)
}

final class Lesson1ViewModel: ObservableObject {
    @Published var menuSections: [MenuSection] = []
    
    init() {
        let firstSection = MenuSection(
            type: .media,
            items: [.wishlist, .download]
        )
        
        let secondSection = MenuSection(
            type: .preferences,
            items: [.theme(true), .language]
        )
        
        let thirdSection = MenuSection(
            type: .account,
            items: [.logout, .privacy, .version("1.2.54b")]
        )
        
        menuSections = [firstSection, secondSection, thirdSection]
    }
}

struct Lesson1View: View {
    
    @StateObject private var viewModel = Lesson1ViewModel()
    
    var body: some View {
        VStack {
            header
            menu
        }
    }
    
}

// MARK: - Menu

private extension Lesson1View {
    
    var menu: some View {
        ScrollView {
            VStack(spacing: 0) {
                LazyVStack(spacing: 21) {
                    ForEach(0..<viewModel.menuSections.count, id: \.self) { index in
                        menuSection(title: viewModel.menuSections[index].type.title)
                        menuSectionItems(section: viewModel.menuSections[index])
                    }
                }
            }
        }
    }
    
    func menuSection(title: String) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(Color.gray.opacity(0.5), in: RoundedRectangle(cornerRadius: 16.0))
            .padding(.leading, 16)
            .padding(.trailing, 31)
    }
}

// MARK: - Header

private extension Lesson1View {
    var header: some View {
        VStack(spacing: 0) {
            Image(systemName: "apple.logo")
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
            VStack(spacing: 12) {
                Text("Jose Phonie")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(UIColor.label))
                
                Text("JosePh12@gmail.com")
                    .font(.callout)
                    .fontWeight(.thin)
                    
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 32)
        }
    }
}

// MARK: - Menu items sections

private extension Lesson1View {
    func menuSectionItems(section: MenuSection) -> some View {
        LazyVStack(spacing: 24) {
            ForEach(0..<section.items.count, id: \.self) { index in
                let menuItem = section.items[index]
                let showDivider = (index != (section.items.count - 1))

                switch menuItem {
                case .wishlist: getWishlistCell(showDivider: showDivider)
                case .theme(let isEnabled): getThemeCell(showDivider: showDivider, isDark: isEnabled)
                case .download: getDownloadCell(showDivider: showDivider)
                case .language: getLanguageCell(showDivider: showDivider)
                case .logout: getLogoutCell(showDivider: showDivider)
                case .privacy: getPrivacyCell(showDivider: showDivider)
                case .version(let name): getVersionCell(showDivider: showDivider, version: name)
                }
            }
        }
        .padding(.leading, 26)
        .padding(.trailing, 31)
    }
}

// MARK: - Whishlist cell

private extension Lesson1View {
    func getWishlistCell(showDivider: Bool) -> some View {
        Button {
            print("Execution whishlist")
        } label: {
            HStack {
                setupCell(icon: "heart")
                setupCell(title: "Wishlist")
                
                Spacer()
                
                chevron
            }
        }
    }
}

// MARK: - Theme cell

private extension Lesson1View {
    func getThemeCell(showDivider: Bool, isDark: Bool) -> some View {
        HStack {
            setupCell(icon: "moon")
            setupCell(title: "Dark mode")
            
            Spacer()
            
            Toggle("", isOn: .constant(true))
        }
    }
}

// MARK: - Download cell

private extension Lesson1View {
    func getDownloadCell(showDivider: Bool) -> some View {
        Button {
            print("Execution download")
        } label: {
            HStack {
                setupCell(icon: "icloud.and.arrow.down")
                setupCell(title: "Download")
                
                Spacer()
                
                chevron
            }
        }
    }
}

// MARK: - Language cell

private extension Lesson1View {
    func getLanguageCell(showDivider: Bool) -> some View {
        Button {
            print("Execution language")
        } label: {
            HStack {
                setupCell(icon: "network")
                setupCell(title: "Language")
                
                Spacer()
                
                chevron
            }
        }
    }
}

// MARK: - Language cell

private extension Lesson1View {
    func getLogoutCell(showDivider: Bool) -> some View {
        Button {
            print("Execution logout")
        } label: {
            HStack {
                setupCell(icon: "rectangle.portrait.and.arrow.right")
                setupCell(title: "Logout")
                
                Spacer()
                
                chevron
            }
        }
    }
}

// MARK: - Privacy cell

private extension Lesson1View {
    func getPrivacyCell(showDivider: Bool) -> some View {
        Button {
            print("Execution privacy")
        } label: {
            HStack {
                setupCell(icon: "person.badge.shield.checkmark.fill")
                setupCell(title: "Privacy")
                
                Spacer()
                
                chevron
            }
        }
    }
}

// MARK: - Version cell

private extension Lesson1View {
    func getVersionCell(showDivider: Bool, version: String) -> some View {
        Button {
            print("Execution privacy")
        } label: {
            HStack {
                setupCell(icon: "doc.append.fill.rtl")
                setupCell(title: "Version: \(version)")
                
                Spacer()
                
                chevron
            }
        }
    }
}

// MARK: - Setup cell icon

private extension Lesson1View {
    func setupCell(icon: String) -> some View {
        Image(systemName: icon)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundStyle(.gray)
    }
}

// MARK: - Setup cell title

private extension Lesson1View {
    func setupCell(title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(Color(UIColor.label))
            .padding(.leading, 10)
    }
}

// MARK: - Setup chevron

private extension Lesson1View {
    var chevron: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 17)
            .foregroundStyle(.gray)
        
    }
}

#Preview {
    Lesson1View()
}
