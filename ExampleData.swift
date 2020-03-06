//
//  ExampleData.swift
//  Todilist
//
//  Created by yanchen on 2020/3/3.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import Foundation


var exampleThings: [thingData] = [
    thingData(value: ["title": "家务", "thingId": "examplejw01", "subtitle": ""]),
    thingData(value: ["title": "学习", "thingId": "examplexx01", "subtitle": ""])
]


var exampletodos: [Todo] = [
    Todo(title: "擦地", dueDate: Date(), i: 0, checked: false, thingId: "examplejw01"),
    Todo(title: "擦2", dueDate: Date(), i: 0, checked: false, thingId: "examplejw01"),
    Todo(title: "洗锅", dueDate: Date(), i: 1, checked: false, thingId: "examplejw01"),
    Todo(title: "看电视", dueDate: Date(), i: 2, checked: false, thingId: "examplejw01"),
    Todo(title: "做APP", dueDate: Date(), i: 3, checked: false, thingId: "examplexx01"),
    Todo(title: "作业", dueDate: Date(), i: 4, checked: false, thingId: "examplexx01")
]
