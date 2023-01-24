import SwiftUI

struct CharacterView: View {
    @State var model: CharacterModel
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ZStack {
                        AsyncImage(url: URL(string: model.image ?? "")) { image in
                            image
                                .resizable()
                                .frame(width: 200.0, height: 200.0)
                                .clipShape(Circle())
                        } placeholder: {
                            Color.gray
                                .frame(width: 200.0, height: 200.0)
                                .clipShape(Circle())
                        }
                        if model.status == "Dead" {
                            HStack {
                                Text("DEAD")
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 200.0)
                            .background(Color.black)
                        }
                    }
                    HStack {
                        Spacer()
                        VStack {
                            HStack {
                                Spacer()
                                Text(model.gender ?? "undefined")
                                Spacer()
                            }
                            .frame(
                                  minWidth: 0,
                                  maxWidth: 100.0,
                                  minHeight: 50.0,
                                  maxHeight: 50.0,
                                  alignment: .center
                            )
                            .background(
                                model.gender == "Male" ? Color("backgroundMale") :
                                model.gender == "Female" ? Color("backgroundFemale") :
                                model.gender == "unknown" ? Color.gray :
                                    Color("backgroundGenderless"))
                            Spacer()
                        }
                    }
                    .padding(.leading, 15)
                }
                  
                HStack {
                    Spacer()
                    Text(model.name ?? "")
                    Spacer()
                }
                .frame(
                      minWidth: 0,
                      maxWidth: 200.0,
                      minHeight: 50.0,
                      maxHeight: 50.0,
                      alignment: .center
                )
                .background(Color("background"))
            }
            .shadow(
                color: Color.gray.opacity(0.7),
                radius: 8,
                x: 0,
                y: 0
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("background"), lineWidth: 1)
            )
            .padding(.bottom, 5)
            .background(Color("cardBackground"))
        }
                    
    }
}
