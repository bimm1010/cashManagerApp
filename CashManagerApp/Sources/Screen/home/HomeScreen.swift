//
//  HomeScreen.swift
//  CaseManager
//
//  Created by Hoàng Nam on 17/4/25.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedTab: Int = 0
    @State private var changeColorButton: Bool = false
    @State private var currentDate: Date = Date()
    @State private var checkItemSAme: Bool = false
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                InputViewCash(
                    changeColorButton: $changeColorButton,
                    currentDay: $currentDate,
                    checkItemSAme: $checkItemSAme
                )
            }
            .tabItem {
                Label("Nhập vào", systemImage: "pencil")
            }
            .tag(0)
            VStack {
                CalenderViewCash()
            }
            .tabItem {
                Label("Calender", systemImage: "calendar")
            }
            .tag(1)
            VStack {
                ChartViewCash()
            }
            .tabItem {
                Label("Chart", systemImage: "chart.pie")
            }
            .tag(2)
            VStack {
                MenuCash()
            }
            .tabItem {
                Label("Khác", systemImage: "ellipsis")
            }
            .tag(3)
        }
        .tint(.green)
        .navigationBarBackButtonHidden(true)
    }
}

struct InputViewCash: View {
    @Binding var changeColorButton: Bool
    @Binding var currentDay: Date
    @Binding var checkItemSAme: Bool
    var body: some View {
        VStack {
            ButtonHeader(changeColorButton: $changeColorButton)
                .padding(.vertical, 5)
            Divider()
            DayViewSelect(currentDay: $currentDay)
            Divider()
            NoteMoneyOut()
            Divider()
            MoneyOutView()
            Divider()
            ListSelectOptions(selectedOption: $checkItemSAme, changeList: $changeColorButton)
            Spacer()
        }
    }
}

struct CalenderViewCash: View {
    var body: some View {
        Text("this is calender view")
    }
}

struct ChartViewCash: View {
    var body: some View {
        Text("this is chart view")
    }
}

struct MenuCash: View {
    var body: some View {
        Text("this is menu view")
    }
}

//Tag 0
struct ButtonHeader: View {
    @Binding var changeColorButton: Bool  //Thằng này để change màu của button header và để thay đổi danh sách list chose
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Rectangle()
                    .frame(width: 240, height: 55)
                    .foregroundStyle(
                        Color(hex: GlobalConfig.colorBackgroundTheme)
                    )
                    .cornerRadius(10)
                    .overlay {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 45)
                                    .foregroundColor(
                                        Color(
                                            hex: changeColorButton
                                                ? GlobalConfig
                                                    .colorBackgroundTheme : GlobalConfig.colorTheme)
                                    )
                                    .onTapGesture {
                                        changeColorButton = false
                                    }
                                Text("Nhập tiền")
                                    .font(.headline)
                                    .foregroundStyle(
                                        Color(
                                            hex: changeColorButton
                                                ? GlobalConfig
                                                    .colorTheme : GlobalConfig.colorWhite)
                                    )
                            }.padding(.horizontal, 5)
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 45)
                                    .foregroundColor(
                                        Color(
                                            hex: changeColorButton
                                                ? GlobalConfig.colorTheme
                                                : GlobalConfig.colorBackgroundTheme
                                        )
                                    )
                                    .onTapGesture {
                                        changeColorButton = true
                                    }
                                Text("tiền thu")
                                    .font(.headline)
                                    .foregroundStyle(
                                        Color(
                                            hex: changeColorButton
                                                ? GlobalConfig.colorWhite : GlobalConfig.colorTheme)
                                    )
                            }.padding(.horizontal, 5)
                        }
                    }
            }
            Spacer()
            Button {
                print("")
            } label: {
                Image(systemName: "applepencil.and.scribble")
            }
        }.padding(.horizontal, 20)
    }
}

struct DayViewSelect: View {
    @Binding var currentDay: Date
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy (E)"
        formatter.locale = Locale(identifier: "vi_VN")
        return formatter
    }()

    var body: some View {
        HStack {
            Text("Day")
                .font(.system(size: 20))
            Spacer()
            Button {
                currentDay =
                    Calendar.current
                    .date(
                        byAdding: .day,
                        value: -1,
                        to: currentDay
                    ) ?? currentDay
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black).font(.system(size: 20))
            }

            Text(dateFormatter.string(from: currentDay)).font(.system(size: 25, weight: .medium))
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.green.opacity(0.1))  // Nền xanh nhạt
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 250, height: 40)

            Button {
                currentDay =
                    Calendar.current
                    .date(
                        byAdding: .day,
                        value: 1,
                        to: currentDay
                    ) ?? currentDay
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.black).font(.system(size: 20))
            }

        }.padding(
            EdgeInsets(
                top: GlobalConfig.GlobalPadding,
                leading: GlobalConfig.GlobalPadding,
                bottom: GlobalConfig.GlobalPadding,
                trailing: GlobalConfig.GlobalPadding
            )
        )
    }
}

struct MoneyOutView: View {
    var body: some View {
        HStack {
            Text("Tiền chi").font(.system(size: 20))
            TextField("nhập tiền chi", text: .constant("0"))
                .background(Color.green.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 30, weight: .bold))
            Text("đ")
        }.padding(
            EdgeInsets(
                top: GlobalConfig.GlobalPadding,
                leading: GlobalConfig.GlobalPadding,
                bottom: GlobalConfig.GlobalPadding,
                trailing: GlobalConfig.GlobalPadding
            )
        )
    }
}

struct NoteMoneyOut: View {
    var body: some View {
        HStack {
            Text("Ghi chú").font(.system(size: 20))
            TextField("chưa nhập vào", text: .constant("")).font(.system(size: 18))
        }.padding(
            EdgeInsets(
                top: GlobalConfig.GlobalPadding,
                leading: GlobalConfig.GlobalPadding,
                bottom: GlobalConfig.GlobalPadding,
                trailing: GlobalConfig.GlobalPadding
            )
        )
    }
}

struct ListSelectOptions: View {
    @Binding var selectedOption: Bool
    @Binding var changeList: Bool
    @State private var selectCategory: Category?
    let colunms = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Danh mục").font(.system(size: 20))
            ScrollView {
                LazyVGrid(columns: colunms, spacing: 10) {
                    ForEach(changeList ? categories2 : categories) { category in  // cần thay đổi thằng categories sang categories2
                        Button {
                            handleCategorySelected(category: category)
                            print(category.name)
                        } label: {
                            VStack(spacing: 5) {
                                Image(category.image)
                                    .resizable()
                                    .frame(width: 40, height: 30)
                                    .foregroundStyle(category.color)
                                    .padding(.vertical, 5)
                                Text(category.name)
                                    .font(.system(size: 15))
                                    .foregroundStyle(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        Color.gray,
                                        lineWidth: selectCategory?.id == category.id ? 4 : 1)
                            )
                        }

                    }
                }
            }.onAppear {
                selectCategory = .init(id: 0, name: "Ăn Uống", image: "eat", color: .orange)
            }
        }.frame(maxWidth: .infinity, alignment: .leading).padding(
            EdgeInsets(
                top: GlobalConfig.GlobalPadding,
                leading: GlobalConfig.GlobalPadding,
                bottom: GlobalConfig.GlobalPadding,
                trailing: GlobalConfig.GlobalPadding
            )
        )
    }
    private func handleCategorySelected(category: Category) {
        if !(selectCategory?.id == category.id) {
            selectCategory = category
        }
    }
}
//-------------------------------------//
