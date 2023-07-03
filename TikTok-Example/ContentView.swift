//
//  ContentView.swift
//  TikTok-Example
//
//  Created by shayanbo on 2023/6/29.
//

import SwiftUI
import VideoPlayerContainer
import AVKit

struct ContentView: View {
    
    @StateObject var context = Context()
    
    var body: some View {
        
        TabView {
            
            PlayerWidget()
                .bindContext(context, launch: [PlaybackService.self])
                .onAppear {
                    
                    context[StatusService.self].toPortrait()
                    
                    let controlService = context[ControlService.self]
                    
                    controlService.configure(displayStyle: .always)
                    
                    controlService.configure(.portrait(.top), shadow: nil)
                    controlService.configure(.portrait(.bottom), shadow: nil)
                    
                    controlService.configure(.portrait(.bottom1)) {[
                        IdentifableView(id: "seek") {
                            SeekBarWidget()
                        }
                    ]}
                    
                    controlService.configure(.portrait(.right)) { views in
                        VStack(spacing: 20) {
                            ForEach(views) { $0 }
                        }
                    }
                    
                    controlService.configure(.portrait(.center)) {[
                        IdentifableView(id: "ar", content: {
                            Spacer().frame(width: 50)
                        })
                    ]}
                    
                    controlService.configure(.portrait(.right)) {[
                        IdentifableView(id: "space", content: { Spacer() }),
                        IdentifableView(id: "person", content: {
                            Image(systemName: "person.fill.badge.plus").resizable().foregroundColor(.white).scaledToFit().frame(width: 30, height: 30)
                        }),
                        IdentifableView(id: "heart", content: {
                            Image(systemName: "heart.fill").resizable().foregroundColor(.white).scaledToFit().frame(width: 30, height: 30)
                        }),
                        IdentifableView(id: "msg", content: {
                            Image(systemName: "ellipsis.message.fill")
                                .resizable().foregroundColor(.white).scaledToFit().frame(width: 30, height: 30)
                                .allowsHitTesting(true)
                                .onTapGesture {
                                    context[FeatureService.self].present(.bottom(.squeeze(0))) {
                                        AnyView(
                                            Form {
                                                Text("hello")
                                                Text("hello")
                                                Text("hello")
                                            }.frame(height: 400)
                                        )
                                    }
                                }
                        }),
                        IdentifableView(id: "star", content: {
                            Image(systemName: "star.fill").resizable().foregroundColor(.white).scaledToFit().frame(width: 30, height: 30)
                        }),
                        IdentifableView(id: "share", content: {
                            Image(systemName: "arrowshape.turn.up.right.fill").resizable().foregroundColor(.white).scaledToFit().frame(width: 30, height: 30)
                        }),
                        IdentifableView(id: "album", content: {
                            Image(systemName: "circle.fill").resizable().foregroundColor(.white).scaledToFit().frame(width: 30, height: 30)
                        }),
                        IdentifableView(id: "margin1", content: {
                            Spacer().frame(height: 0)
                        }),
                    ]}
                    
                    controlService.configure(.portrait(.left)) { views in
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(views) { $0 }
                        }
                    }
                    
                    controlService.configure(.portrait(.left)) {[
                        IdentifableView(id: "margin", content: {
                            Spacer()
                        }),
                        IdentifableView(id: "title", content: {
                            Text("@Taylor Swift")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }),
                        IdentifableView(id: "desc", content: {
                            Text("HahahahahhahahahhahahahhahahahhahahahhahahahhahahahHahahahahhahahahhahahahhahahahhahahahhahahahhahahah")
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                        }),
                        IdentifableView(id: "bottom", content: {
                            Spacer().frame(height: 0)
                        }),
                    ]}
                    
                    context[RenderService.self].fill()
                    
                    let player = context[RenderService.self].player
                    
                    player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2023/10036/4/BB960BFD-F982-4800-8060-5674B049AC5A/cmaf/hvc/2160p_16800/hvc_2160p_16800.m3u8")!))
                    player.play()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
                .tabItem {
                    Label("Home", systemImage: "house.circle.fill")
                }
            
            Text("Second Page")
                .tabItem {
                    Label("Friends", systemImage: "link.circle.fill")
                }
            
            Text("Third Page")
                .tabItem {
                    Label("Message", systemImage: "message.circle.fill")
                }
            
            Text("Forth Page")
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
