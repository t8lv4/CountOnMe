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

    // MARK: Helpers

    /// Create arrays of numbers and binary operation symbols
    func appendSymbolsAndNumbers(_ numbers: [String], _ symbol: [String]) {
        reckon.numberArray = numbers
        reckon.operationSymbolArray = symbol
    }

    /**
     Create random binary operations sequence with an arbitrary amount of numbers
     - Note: **swift 4.2 will better handle randomness.
     To be rewritten!**
     */
    func randomlyAppendReckonArrays(loop count: Int, range: UInt32) {
        reckon.numberArray.removeAll()

        for _ in 0...count {
            let anyNumber = Int(arc4random_uniform(range))
            reckon.numberArray.append(String(anyNumber))

            let availableOperationSymbols = ["+", "-"]
            let randomIndex = Int(arc4random_uniform(UInt32(availableOperationSymbols.count)))
            let anyOperationSymbol = availableOperationSymbols[randomIndex]
            reckon.operationSymbolArray.append(anyOperationSymbol)
        }
    }

    // MARK: Unit Tests

    // MARK: Test appending and resetting

    /// Test appending numbers array
    func testGivenBufferIsEmpty_WhenAdding7_ThenBufferShouldContain7() {
        reckon.concatenateNumbers(7)

        XCTAssertTrue(reckon.numberArray.contains("7"))
    }

    /// Test appending operation symbol array
    func testGivenOperationSymbolIsEmpty_WhenAddingPlus_ThenArrayShouldContainPlusSign() {
        reckon.appendOperationSymbol(with: "plus")

        XCTAssertTrue(reckon.operationSymbolArray.contains("+"))
    }

    /// Test numbers concatenation
    func testGivenNumberArrayContains7_WhenAdding3_ThenArrayShouldContainNumber73() {
        reckon.numberArray[0] = "7"

        reckon.concatenateNumbers(3)

        XCTAssertTrue(reckon.numberArray[0] == "73")
    }

    /// Test the change occured in the numbers array when adding an operation symbol
    func testGivenNumberArrayContains3_WhenAddingOperationSymbol_ThenLastArraysValuesShouldBeEmptyAndMinus() {
        reckon.numberArray[0] = "3"

        reckon.appendOperationSymbol(with: "minus")

        XCTAssertTrue(reckon.numberArray.last == "")
        XCTAssertTrue(reckon.operationSymbolArray.last == "-")
    }

    /// Test resetting arrays to default values
    func testGivenSumming2And6_WhenResetting_ThenArraysShouldBeEmptyStringAndPlusSign() {
        appendSymbolsAndNumbers(["2", "6"], ["+", "+"])

        reckon.resetArrays()

        XCTAssertEqual(reckon.numberArray, [""])
        XCTAssertEqual(reckon.operationSymbolArray, ["+"])
    }

    // MARK: Test binary operations results validity

    /// Test addition
    func testGivenNumberArrayContains4And5_WhenSumming_ThenResultShouldBe9() {
        appendSymbolsAndNumbers(["4", "5"], ["+", "+"])

        let sum = Int(reckon.numberArray[0])! + Int(reckon.numberArray[1])!

        XCTAssertTrue(reckon.returnResult() == sum)
    }

    /// Test subtraction
    func testGivenNumberArrayContains8And5_WhenSubtracting_ThenResultShouldBe3() {
        appendSymbolsAndNumbers(["8", "5"], ["+", "-"])

        let subtraction = Int(reckon.numberArray[0])! - Int(reckon.numberArray[1])!

        XCTAssertTrue(reckon.returnResult() == subtraction)
    }

    // MARK: Test expressions to reckon validity

    /// Test invalid expression input: two operation symbols in a row
    func testGivenArraysContain1AndAnySign_WhenAddingAnyOperationSymbol_ThenExpressionShouldBeRejected() {
        appendSymbolsAndNumbers(["1", ""], ["+", "-"])

        reckon.appendOperationSymbol(with: "plus")

        XCTAssertFalse(reckon.canAddOperationSymbol("plus"))
    }

    /// Test invalid expression input: equal on an empty array
    func testGivenArraysAreReset_WhenReckoningExpression_ThenExpressionShouldBeRejectedWith0() {
        reckon.resetArrays()

        let validity = reckon.isExpressionCorrect()

        XCTAssertEqual(validity, 0)
    }

    /// Test invalid expression input: equal on a single number
    func testGivenNumberArrayLastElementIsEmpty_WhenReckoningExpression_ThenExpressionShouldBeRejectedWith1() {
        reckon.numberArray = ["2", ""]

        let validity = reckon.isExpressionCorrect()

        XCTAssertEqual(validity, 1)
    }

    /// Test an arbitrary number of operations on random Int
    func testGivenAnyOperationWithAnyNumbers_WhenReckonningExpression_ThenEpressionShouldBeValid() {
        randomlyAppendReckonArrays(loop: 5, range: 100)

        let validity = reckon.isExpressionCorrect()

        XCTAssertEqual(validity, 2)
    }

    /// Test Reckon calculate a result whatever the amount of binary operations
    func testGivenAnyOperationWithAnyNumbers_WhenQueryingAResult_ThenReckonShouldGiveAresult() {
        randomlyAppendReckonArrays(loop: 10000, range: 10000)

        let result: Int? = reckon.returnResult()

        XCTAssert(result != nil)
    }

}
