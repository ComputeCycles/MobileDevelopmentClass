//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let shader =
    "#include <metal_stdlib>\n" +
        "using namespace metal;" +
        "kernel void k(texture2d<float,access::write> o[[texture(0)]]," +
        "              uint2 gid[[thread_position_in_grid]]) {" +
        "   float3 color = float3(0.5, 0.8, 1.0);" +
        "   o.write(float4(color, 1.0), gid);" +
"}"

import MetalKit
import PlaygroundSupport

class MetalView: MTKView {
    override func draw(_ dirtyRect: CGRect) {
        super.draw(dirtyRect)
        render()
    }
    
    func render() {
        let device = MTLCreateSystemDefaultDevice()!
        self.device = device
        let rpd = MTLRenderPassDescriptor()
        let bleen = MTLClearColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
        rpd.colorAttachments[0].texture = currentDrawable!.texture
        rpd.colorAttachments[0].clearColor = bleen
        rpd.colorAttachments[0].loadAction = .clear
        let commandQueue = device.makeCommandQueue()
        let commandBuffer = commandQueue.makeCommandBuffer()
        let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: rpd)
        encoder.endEncoding()
        commandBuffer.present(currentDrawable!)
        commandBuffer.commit()
    }
}

let frame = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0)
let view = MTKView(frame: frame)
let delegate = MetalView(
view.delegate = delegate
PlaygroundPage.current.liveView = view
