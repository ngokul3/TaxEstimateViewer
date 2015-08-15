//
//  CapitalGain_Tax_CalculatorTests.swift
//  CapitalGain Tax CalculatorTests
//
//  Created by Gokul Narasimhan on 7/14/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import UIKit
import XCTest


class CapitalGain_Tax_CalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Single - 2015
  
    func testSingleTaxEstimate_2015_Single_Base()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 11260
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 6110
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Single
        filingStatus.CurrentTaxableIncome = 135000
        filingStatus.Year = 2015

        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(filingStatus.TaxOnLTSTCapitalGain, 3399.8, "Single")
    }
    
    func testSingleTaxEstimate_2015_Single_Base_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 11260
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 6110
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = -10000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Single
        filingStatus.CurrentTaxableIncome = 135000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(1379.8), "Single")
    }
    
    func testSingleTaxEstimate_2015_Single_2TaxBrackets()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 28000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 5000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)

  
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Single
        filingStatus.CurrentTaxableIncome = 70750
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(5450), "Single")
    }
    
    func testSingleTaxEstimate_2015_Single_2TaxBrackets_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 28000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 5000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 32000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)

        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Single
        filingStatus.CurrentTaxableIncome = 70750
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(11530), "Single")
    }
    
    // End
    
    
    // JOINT
    func testJointTaxEstimate_2015_Joint_2TaxBrackets()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 300000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 150000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Joint
        filingStatus.CurrentTaxableIncome = 230000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(109455), "Joint")
    }

    func testJointTaxEstimate_2015_2TaxBrackets2()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 200000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = -10000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Joint
        filingStatus.CurrentTaxableIncome = 300000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(32425), "Joint")
    }
    
    func testJointTaxEstimate_2015_Joint_2TaxBrackets_2()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 120000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = -70000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
     
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Joint
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(7500), "Joint")

    }
    
    func testJointTaxEstimate_2015_Joint_2TaxBrackets_2_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 120000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = -70000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 32000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
        

        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Joint
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(12300), "Joint")
        
    }
    
    func testJointTaxEstimate_2015_2TaxBrackets_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 300000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 150000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 32000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)

        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Joint
        filingStatus.CurrentTaxableIncome = 230000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(117519), "Joint")
    }

    func testJointTaxEstimate_2015_Joint_FullNetLoss()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = -200000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = -10000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 0
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
 
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Joint
        filingStatus.CurrentTaxableIncome = 300000
        filingStatus.Year = 2015

        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.NetLoss), round(-210000), "Joint")

    }
    
    func testJointTaxEstimate_2015_Joint_FullNetLoss_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = -200000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 1000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = -32000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Joint
        filingStatus.CurrentTaxableIncome = 300000
        filingStatus.Year = 2015
        

        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.NetLoss), round(-231000), "Joint")
        
    }
    
    func testJointTaxEstimate_2015_2TaxBrackets_NetLoss_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 30000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 15000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = -200000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
        
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Joint
        filingStatus.CurrentTaxableIncome = 230000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.NetLoss), round(-155000), "Joint")
         XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(0), "Joint")
    }

    // END
    
    //HOH
    func testHOHTaxEstimate_2015_HoH_NetLoss()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = -120000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 70000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.HoH
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.NetLoss), round(-50000), "HOH")

    }
    
    func testHOHTaxEstimate_2015_NetLoss_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = -120000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 70000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 32000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)

        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.HoH
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.NetLoss), round(-18000), "HOH")
        
    }
    
    func testHOHTaxEstimate_2015_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = -70000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 120000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 32000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.HoH
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(26567.5), "HOH")
        
    }
    
    
    func testHOHTaxEstimate_2015()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = -70000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 120000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 0
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.HoH
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(16007.5), "HOH")
        
    }
   
    func testHOHTaxEstimate_2015_TaxBracket_3Years()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 20000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 5000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.HoH
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(4400), "HOH")
        
        lstLotTerm = [LotTerm]()
        
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 20000
        lotTerm1.Year = 2014
        lstLotTerm.append(lotTerm1)
        
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 50000
        lotTerm2.Year = 2014
        lstLotTerm.append(lotTerm2)

        
        filingStatus.FilingType = ENumFilingType.HoH
        filingStatus.CurrentTaxableIncome = 179300
        filingStatus.Year = 2014
     
     //   filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
     //   XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(17972.5), "HOH")
        
        
        lstLotTerm = [LotTerm]()
        
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 20000
        lotTerm1.Year = 2013
        lstLotTerm.append(lotTerm1)
        
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 50000
        lotTerm2.Year = 2013
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 32000
        lotTerm3.Year = 2013
        lstLotTerm.append(lotTerm3)
 
        
        filingStatus.FilingType = ENumFilingType.HoH
        filingStatus.CurrentTaxableIncome = 179300
        filingStatus.Year = 2013
        
        //   filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        //   XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(25076.5), "HOH")


    }

    
    func testHOHTaxEstimate_2015_2TaxBrackets_3Years_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 20000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 5000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = -12000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.HoH
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(1976), "HOH")
        
        lstLotTerm = [LotTerm]()
        
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 20000
        lotTerm1.Year = 2014
        lstLotTerm.append(lotTerm1)
        
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 50000
        lotTerm2.Year = 2014
        lstLotTerm.append(lotTerm2)
        
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 72000
        lotTerm3.Year = 2014
        lstLotTerm.append(lotTerm3)
        
        
        filingStatus.FilingType = ENumFilingType.HoH
        filingStatus.CurrentTaxableIncome = 179300
        filingStatus.Year = 2014
        
        //   filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        //   XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(33956.5), "HOH")
        
        
        lstLotTerm = [LotTerm]()
        
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 20000
        lotTerm1.Year = 2013
        lstLotTerm.append(lotTerm1)
        
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = 50000
        lotTerm2.Year = 2013
        lstLotTerm.append(lotTerm2)
        
         lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 32000
        lotTerm3.Year = 2013
        lstLotTerm.append(lotTerm3)
        
        
        filingStatus.FilingType = ENumFilingType.Single
        filingStatus.CurrentTaxableIncome = 179300
        filingStatus.Year = 2013
        
        //   filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        //   XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(25076.5), "HOH")
        
        
    }
    
    // HOH END
    
    // Separate
    
    func testSeparateTaxEstimate_2015_Separate_2TaxBrackets()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 50000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = -20000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = 0.00
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Separate
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(4500), "Separate")
    }
    
    
    func testSeparateTaxEstimate_2015_Separate_2TaxBrackets_1256()
    {
        let taxProcessor = TaxProcessor()
        
        var lstLotTerm = [LotTerm]()
        let lotTerm1 = LotTerm()
        lotTerm1.Term = ENumTerm.LongTerm
        lotTerm1.TermRealizedGainLoss = 50000
        lotTerm1.Year = 2015
        lstLotTerm.append(lotTerm1)
        
        let lotTerm2 = LotTerm()
        lotTerm2.Term = ENumTerm.ShortTerm
        lotTerm2.TermRealizedGainLoss = -20000
        lotTerm2.Year = 2015
        lstLotTerm.append(lotTerm2)
        
        let lotTerm3 = LotTerm()
        lotTerm3.Term = ENumTerm.Section1256
        lotTerm3.TermRealizedGainLoss = -28000
        lotTerm3.Year = 2015
        lstLotTerm.append(lotTerm3)
        
        var filingStatus = FilingStatus()
        
        filingStatus.FilingType = ENumFilingType.Separate
        filingStatus.CurrentTaxableIncome = 200000
        filingStatus.Year = 2015
        
        filingStatus = taxProcessor.GetTaxableIncome(filingStatus, lstLotTerm: lstLotTerm)
        
        XCTAssertEqual(round(filingStatus.TaxOnLTSTCapitalGain), round(300), "Separate")
    }
    
    
}
