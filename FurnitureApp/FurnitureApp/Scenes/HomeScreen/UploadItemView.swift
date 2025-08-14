//
//  UploadItemView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 12/08/2025.
//

//import SwiftUI
//import PhotosUI
//
//struct UploadItemView: View {
//    @State private var selectedItems: [PhotosPickerItem] = []
//    @State private var selectedImages: [UIImage] = []
//    @State private var descriptionText: String = ""
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 15) {
//
//                        PhotosPicker(selection: $selectedItems,
//                                     maxSelectionCount: 5,
//                                     matching: .images) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(Color.blue.opacity(0.1))
//                                    .frame(width: 100, height: 100)
//                                    .overlay(
//                                        Image(systemName: "plus")
//                                            .font(.system(size: 30))
//                                            .foregroundColor(.blue)
//                                    )
//                            }
//                        }
//
//                        ForEach(selectedImages.indices, id: \.self) { index in
//                            Image(uiImage: selectedImages[index])
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 100, height: 100)
//                                .clipShape(RoundedRectangle(cornerRadius: 12))
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//
//                TextField("Write description...", text: $descriptionText, axis: .vertical)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(12)
//                    .lineLimit(5, reservesSpace: true)
//                    .frame(maxHeight: 150)
//
//                Button(action: {
//                    uploadImages()
//                }) {
//                    Text("Upload")
//                        .font(.custom("Inter-Bold", size: 18))
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(40)
//                }
//                .padding(.top, 20)
//
//                Spacer()
//            }
//            .padding()
//            .navigationTitle("Upload")
//            .onChange(of: selectedItems) { newItems in
//                Task {
//                    selectedImages.removeAll()
//                    for item in newItems {
//                        if let data = try? await item.loadTransferable(type: Data.self),
//                           let uiImage = UIImage(data: data) {
//                            selectedImages.append(uiImage)
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    func uploadImages() {
//        print("Selected \(selectedImages.count) images with description: \(descriptionText)")
//        // firebase upload
//
//    }
//}
//
//struct UploadItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadItemView()
//    }
//}
