//
//  Home.swift
//  AppStoreToolKit (macOS)
//
//  Created by kidstyo on 2022/2/26.
//

import SwiftUI

struct Home: View {
    @StateObject var iconViewModel = IconViewModel()
    @Environment(\.self) var env

    var body: some View {
        VStack(spacing: 15){
            if let image = iconViewModel.pickedImage{
                // MARK: Displaying Image with Action
                Group{
                    Image(nsImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 250)
                        .clipped()

                    Button {
                        iconViewModel.generateIconSet()
                    } label: {
                        Text("Generate Icon Set")
                            .foregroundColor(env.colorScheme == .dark ? .black : .white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 18)
                            .background(.primary, in: RoundedRectangle(cornerRadius: 10))
                    }

                }
            }
            else{
                ZStack{
                    Button {
                        iconViewModel.PickImage()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(env.colorScheme == .dark ? .black : .white)
                            .padding(15)
                            .background(.primary, in: RoundedRectangle(cornerRadius: 10))
                    }


                    // Recommended Size
                    Text("1024 X 1024 is recommended!")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
        .frame(width: 400, height: 400)
        .buttonStyle(.plain)
        .alert(iconViewModel.alertMsg, isPresented: $iconViewModel.showAlert) {

        }
        // MARK: Loading View
        .overlay {
            ZStack{
                if iconViewModel.isGenerating
                {
                    Color.black.opacity(0.25)

                    ProgressView()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 10))
                    //Alwarys Light Mode
                        .environment(\.colorScheme, .light)
                }
            }
        }
        .animation(.easeInOut, value: iconViewModel.isGenerating)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
