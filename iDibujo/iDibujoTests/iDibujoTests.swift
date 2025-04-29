//
//  iDibujoTests.swift
//  iDibujoTests
//
//  Created by Israel Manzo on 6/16/23.
//  Copyright © 2023 Israel Manzo. All rights reserved.
//

import XCTest
import SwiftUI
@testable import iDibujo

final class iDibujoTests: XCTestCase {
    
    var canvasViewModel: CanvasViewModel!
    var canvasProtocol: CanvasViewModelProtocol!
    var lineViewModel: LineViewModel!

    override func setUpWithError() throws {
        canvasViewModel = CanvasViewModel()
        lineViewModel = LineViewModel()
    }

    override func tearDownWithError() throws {
        canvasViewModel = nil
        canvasProtocol = nil
        lineViewModel = nil
    }
    
    func testInitialValues() {
        XCTAssertEqual(lineViewModel.lineWithValue, 5.0, "Default line width should be 5.0")
        XCTAssertTrue(lineViewModel.lines.isEmpty, "Lines should be empty initially")
        XCTAssertEqual(lineViewModel.colors.count, 7, "Colors should have 7 default colors")
        XCTAssertEqual(lineViewModel.selectedColor, Color.black, "Selected color should be black by default")
        XCTAssertTrue(lineViewModel.deletedLines.isEmpty, "Deleted lines should be empty initially")
        XCTAssertFalse(lineViewModel.isSaved, "isSaved should be false initially")
    }
    
    func testUpdateLineWidth() {
        lineViewModel.lineWithValue = 10.0
        XCTAssertEqual(lineViewModel.lineWithValue, 10.0, "Line width should update correctly")
    }
    
    func testAddLine() {
        let line = Line(points: [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 10)], color: .red, width: 5.0)
        lineViewModel.lines.append(line)
        XCTAssertEqual(lineViewModel.lines.count, 1, "Should have one line after adding")
    }
    
    func testCanvasColorsExisting() {
        let blue = canvasViewModel.draw.blue
        let red = canvasViewModel.draw.red
        let green = canvasViewModel.draw.green
        let opacity = canvasViewModel.draw.opacity
        let brushSize = canvasViewModel.draw.brushSize
        let lastPoint = canvasViewModel.draw.lastPoint
        let swipe = canvasViewModel.draw.swipe
        let isDrawing = canvasViewModel.draw.isDrawing
        let containerView = canvasViewModel.draw.container
        XCTAssertEqual(red, 0.0)
        XCTAssertEqual(blue, 0.0)
        XCTAssertEqual(green, 0.0)
        XCTAssertEqual(opacity, 1.0)
        XCTAssertEqual(brushSize, 9.0)
        XCTAssertEqual(lastPoint, .zero)
        XCTAssertEqual(swipe, false)
        XCTAssertEqual(isDrawing, true)
        XCTAssertNotNil(containerView)
        if containerView.image == nil {
            XCTAssertNotNil(containerView)
        } else {
            XCTAssertNil(containerView)
        }
        
    }
    
    func testContainerViewImageForGraphicCurrentImageContext() {
        let containerView = canvasViewModel.draw.container
        if containerView.image == nil {
            XCTAssertNotNil(containerView)
        } else {
            XCTAssertNil(containerView)
        }
    }
    
    func testColorPickerSliderValueSenderTag() {
        let sender = UISlider()
        let equal: Bool
        switch sender.tag {
        case 0:
            (canvasViewModel.draw.red, canvasViewModel.draw.green, canvasViewModel.draw.blue) = (1, 0, 0)
            equal = (canvasViewModel.draw.red, canvasViewModel.draw.green, canvasViewModel.draw.blue) == (1, 0, 0)
            XCTAssert(equal)
        case 1:
            equal = (canvasViewModel.draw.red, canvasViewModel.draw.green, canvasViewModel.draw.blue) == (0, 1, 0)
            XCTAssert(equal)
        case 2:
            equal = (canvasViewModel.draw.red, canvasViewModel.draw.green, canvasViewModel.draw.blue) == (0, 0, 1)
            XCTAssert(equal)
        case 3:
            equal = (canvasViewModel.draw.red, canvasViewModel.draw.green, canvasViewModel.draw.blue) == (1, 0, 1)
            XCTAssert(equal)
        case 4:
            equal = (canvasViewModel.draw.red, canvasViewModel.draw.green, canvasViewModel.draw.blue) == (1, 1, 0)
            XCTAssert(equal)
        case 5:
            equal = (canvasViewModel.draw.red, canvasViewModel.draw.green, canvasViewModel.draw.blue) == (0, 1, 1)
            XCTAssert(equal)
        case 6:
            equal = (canvasViewModel.draw.red, canvasViewModel.draw.green, canvasViewModel.draw.blue) == (1, 1, 1)
            XCTAssert(equal)
        case 7:
            equal = (canvasViewModel.draw.red, canvasViewModel.draw.green, canvasViewModel.draw.blue) == (0, 0, 0)
            XCTAssert(equal)
        default:
            break
        }
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
