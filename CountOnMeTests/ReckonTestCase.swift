//
//  ReckonTestCase.swift
//  CountOnMeTests
//
//  Created by Morgan on 01/09/2018.
//

import XCTest
@testable import CountOnMe

class ReckonTestCase: XCTestCase {
    var reckon = Reckon()

    override func setUp() {
        super.setUp()
        reckon = Reckon()
    }

    /* swift 4.2 will better handle randomness.
     to be rewritten!
     */
    func randomlyAppendReckonArrays(loop count: Int, range: Int) {
        reckon.numberArray.removeAll()

        for _ in 0...count {
            let anyNumber = Int(arc4random_uniform(100))
            reckon.numberArray.append(String(anyNumber))

            let availableOperationSymbols = ["+", "-"]
            let randomIndex = Int(arc4random_uniform(UInt32(availableOperationSymbols.count)))
            let anyOperationSymbol = availableOperationSymbols[randomIndex]
            reckon.operationSymbolArray.append(anyOperationSymbol)
        }
    }

    func testGivenBufferIsEmpty_WhenAdding7_ThenBufferShouldContain7() {
        reckon.addNewNumber(7)

        XCTAssertTrue(reckon.numberArray.contains("7"))
    }

    func testGivenOperationSymbolIsEmpty_WhenAddingPlus_ThenArrayShouldContainPlusSign() {
        reckon.appendOperationSymbol(with: "plus")

        XCTAssertTrue(reckon.operationSymbolArray.contains("+"))
    }

    func testGivenNumberArrayContains7_WhenAdding3_ThenArrayShouldContainNumber73() {
        reckon.numberArray[0] = "7"

        reckon.addNewNumber(3)

        XCTAssertTrue(reckon.numberArray[0] == "73")
    }

    func testGivenNumberArrayContains3_WhenAddingOperationSymbol_ThenLastArraysValuesShouldBeEmptyAndMinus() {
        reckon.numberArray[0] = "3"

        reckon.appendOperationSymbol(with: "minus")

        XCTAssertTrue(reckon.numberArray.last == "")
        XCTAssertTrue(reckon.operationSymbolArray.last == "-")
    }

    func testGivenNumberArrayContains4And5_WhenSumming_ThenResultShouldBe9() {
        reckon.numberArray = ["4", "5"]
        reckon.operationSymbolArray = ["+", "+"]

        let sum = Int(reckon.numberArray[0])! + Int(reckon.numberArray[1])!

        XCTAssertTrue(reckon.returnResult() == sum)
    }

    func testGivenNumberArrayContains8And5_WhenSubtracting_ThenResultShouldBe3() {
        reckon.numberArray = ["8", "5"]
        reckon.operationSymbolArray = ["+", "-"]

        let subtraction = Int(reckon.numberArray[0])! - Int(reckon.numberArray[1])!

        XCTAssertTrue(reckon.returnResult() == subtraction)
    }

    func testGivenSumming2And6_WhenResetting_ThenArraysShouldBeEmptyStringAndPlusSign() {
        reckon.numberArray = ["2", "6"]
        reckon.operationSymbolArray = ["+", "+"]

        reckon.resetArrays()

        XCTAssertEqual(reckon.numberArray, [""])
        XCTAssertEqual(reckon.operationSymbolArray, ["+"])
    }

    func testGivenArraysContain1AndAnySign_WhenAddingAnyOperationSymbol_ThenExpressionShouldBeRejected() {
        reckon.numberArray = ["1", ""]
        reckon.operationSymbolArray = ["+", "-"]

        reckon.appendOperationSymbol(with: "plus")

        XCTAssertFalse(reckon.canAddOperationSymbol("plus"))
    }

    func testGivenArraysAreReset_WhenReckoningExpression_ThenExpressionShouldBeRejectedWith0() {
        reckon.resetArrays()

        let validity = reckon.isExpressionCorrect()

        XCTAssertEqual(validity, 0)
    }

    func testGivenNumberArrayLastElementIsEmpty_WhenReckoningExpression_ThenExpressionShouldBeRejectedWith1() {
        reckon.numberArray = ["2", ""]

        let validity = reckon.isExpressionCorrect()

        XCTAssertEqual(validity, 1)
    }

    func testGivenAnyOperationWithAnyNumbers_WhenReckonningExpression_ThenEpressionShouldBeValid() {
        randomlyAppendReckonArrays(loop: 5, range: 100)

        let validity = reckon.isExpressionCorrect()

        XCTAssertEqual(validity, 2)
    }

    func testGivenAnyOperationWithAnyNumbers_WhenQueryingAResult_ThenReckonShouldGiveAresult() {
        randomlyAppendReckonArrays(loop: 10000, range: 10000)

        let result: Int? = reckon.returnResult()

        XCTAssert(result != nil)
    }

}
