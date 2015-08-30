//
//  LotPosition.swift
//  CapitalGain Tax Calculator
//
//  Created by Gokul Narasimhan on 7/15/15.
//  Copyright (c) 2015 BigRoom. All rights reserved.
//

import Foundation

enum ENumDirection:String{
    case Long = "Long"
    case CoveredShort = "Short"
    case UnCoveredShort = "Covered Short / Straddle"
}

enum ENumInvestmentType:String{
    case Equity="Stock / Bond / Option / ETF ..etc"
    case Dividend="Qualified Dividend"
    case NonQualifiedDividend="Non-qualified Dividend"
    case Section1256 = "Section 1256"
    
    func associatedValue(investmentType : ENumInvestmentType) -> String {
        switch investmentType {
        case .Equity:
            return "Equity"
        case .Dividend:
            return "Dividend"
        case .NonQualifiedDividend:
            return "NonQualifiedDividend"
        case .Section1256:
            return "Section1256"

        default:
            return ""
        }
    }
    
    func associatedEnum(strInvestmentType : String) -> ENumInvestmentType {
        switch strInvestmentType {
        case "Equity":
            return ENumInvestmentType.Equity
        case "Dividend":
            return ENumInvestmentType.Dividend
        case "NonQualifiedDividend":
            return ENumInvestmentType.NonQualifiedDividend
        case "Section1256":
            return ENumInvestmentType.Section1256
            
        default:
            return ENumInvestmentType.Equity
        }
    }
}
class LotPosition{
    private var _lotId:Int32
    private var _symbolCode:String
    private var _investmentType:ENumInvestmentType
    private var _direction:ENumDirection
    private var _realizedGainLoss: Double
    private var _realizedYear: Int
    private var _isLongTerm : Bool
    private var _isSelected : Bool
  
    init()
    {
        self._symbolCode = ""
        self._investmentType = ENumInvestmentType.Equity
        self._direction = ENumDirection.Long
        self._lotId = 0
        self._realizedGainLoss = 0
        self._realizedYear=0
        self._isLongTerm = false
        self._isSelected = true
    }
    init(lotId:Int32,symbolCode:String,investmentType:ENumInvestmentType,direction: ENumDirection,realizedGainLoss:Double,realizedYear:Int,IsLongTerm:Bool
        )
    {
        self._lotId = lotId
        self._symbolCode = symbolCode
        self._investmentType = investmentType
        self._direction = direction
        self._realizedGainLoss = realizedGainLoss
        self._realizedYear = realizedYear
        self._isLongTerm = false
         self._isSelected = true
        
    }   
    
    var LotId: Int32 {
        get {
            return _lotId
        }
        set {
            _lotId = newValue
        }
    }
    
    var SymbolCode: String {
        get {
           return _symbolCode
        }
        set {
         _symbolCode = newValue
        }
    }
    
    var InvestmentType: ENumInvestmentType {
        get {
            return _investmentType
        }
        set {
            _investmentType = newValue
        }
    }
  
    var Direction: ENumDirection {
        get {
            return _direction
        }
        set {
            _direction = newValue
        }
    }
    
    var RealizedGainLoss: Double {
        get {
            return _realizedGainLoss
        }
        set {
            _realizedGainLoss = newValue
        }
    }

    
    var RealizedYear: Int {
        get {
            return _realizedYear
        }
        set {
            _realizedYear = newValue
        }
    }

    var IsLongTerm: Bool {
        get {
            return _isLongTerm
        }
        set {
            _isLongTerm = newValue
        }
    }
    
    var IsSelected: Bool {
        get {
            return _isSelected
        }
        set {
            _isSelected = newValue
        }
    }

    func GetStockDetail()->String?{
        switch self._symbolCode
        {
            case "AAPL":
            return "Apple"
            
            case "CTSH":
            return "Cogniaznant"
            
        default:
            return "TCS"
            
        }
    }
}