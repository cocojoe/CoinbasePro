//
//  CBOOrdersSpec.swift
//  CoinbaseProTests
//
//  Created by Martin Walsh on 20/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Quick
import Nimble
@testable import CoinbasePro


class CBOOrdersSpec: QuickSpec {
    override func spec() {
        
        describe("init") {
            
            it("should return instance of CBPOrders") {
                let request  = Request(withAPIKey: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase, network: NetworkMock())
                let orders = CBPOrders(request: request)
                expect(orders).to(beAnInstanceOf(CBPOrders.self))
            }
        }
        
        describe("orders") {
            
            var network: NetworkMock!
            var request: Request!
            var orders: CBPOrders!
            
            beforeEach {
                network = NetworkMock()
                request = Request(withAPIKey: Constants.APIKey, secret: Constants.APISecret, phrase: Constants.APIPhrase, network: network)
                orders = CBPOrders(request: request)
            }
            
            describe("list orders") {
                
                it("should yield array of order objects") {
                    network.setJSONData(fromFile: Constants.Orders.JSONArray)
                    orders.list { error, result in
                        expect(error).to(beNil())
                        expect(result.order).to(beAnInstanceOf(Array<Order>.self))
                    }
                }
                
                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    orders.list { error, result in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(result.order).to(beNil())
                    }
                }
                
                context("with params") {
                    
                    it("should set default status of all in request params") {
                        orders.list { error, result in
                            expect(network.parameters["status"]) == "all"
                        }
                    }
                    
                    it("should set status of open in request params") {
                        orders.list(withStatus: "open")  { error, result in
                            expect(network.parameters["status"]) == "open"
                        }
                    }
                    
                    it("should set product_id of USD-BTC in request params") {
                        orders.list(productId: "USD-BTC")  { error, result in
                            expect(network.parameters["product_id"]) == "USD-BTC"
                        }
                    }
                }
                
                
                context("pagination") {
                    it("should set limit") {
                        let order = orders.limit(5)
                        expect(order.params["limit"]) == String(5)
                    }
                    
                    it("should set before") {
                        let order = orders.nextPage("PAGE1")
                        expect(order.params["after"]) == "PAGE1"
                    }
                    
                    it("should set after") {
                        let order = orders.previousPage("PAGE2")
                        expect(order.params["before"]) == "PAGE2"
                    }
                }
            }
            
            describe("place order") {
                
                it("should yield an order object") {
                    network.setJSONData(fromFile: Constants.Orders.JSONObject)
                    orders.buy(withPrice: "2400", size: "0.1", side: "buy", productId: "BTC-USD") { error, result in
                        expect(error).to(beNil())
                        expect(result).to(beAnInstanceOf(Order.self))
                    }
                }
                
                it("should yield bad data error") {
                    network.setInvalidJSONData()
                    orders.buy(withPrice: "2400", size: "0.1", side: "buy", productId: "BTC-USD") { error, result in
                        expect(error).to(beAnInstanceOf(CoinbaseProError.self))
                        expect(result).to(beNil())
                    }
                }
                
                context("check post body") {
                    
                    it("should set price of 2400 in request body") {
                        orders.buy(withPrice: "2400", size: "0.1", side: "buy", productId: "BTC-USD") { error, result in
                            expect(error).to(beNil())
                            expect(network.body).to(contain("2400"))
                        }
                    }
                }
            }
        }
    }
}
