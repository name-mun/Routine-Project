//
//  StickerData.swift
//  Routine
//
//  Created by mun on 12/29/24.
//

import Foundation

struct StickerData {
    static let data: [StickerData] = [
        StickerData(
            category: "건물",
            stickers: ["house.fill", "building.2.fill", "storefront.fill"]
        ),
        StickerData(
            category: "자기계발",
            stickers: ["checklist", "curlybraces", "brain.head.profile", "lightbulb.fill", "person.fill", "person.2.fill", "target", "laptopcomputer", "calendar"]
        ),
        StickerData(
            category: "커뮤니케이션",
            stickers: ["message.fill", "phone.fill", "envelope.fill", "person.crop.circle.fill"]
        ),
        StickerData(
            category: "반려동물",
            stickers: ["pawprint.fill", "tortoise.fill", "fish.fill", "bird.fill"]
        ),
        StickerData(
            category: "음식",
            stickers: ["fork.knife", "cup.and.saucer.fill", "takeoutbag.and.cup.and.straw.fill", "birthday.cake.fill"]
        ),
        StickerData(
            category: "청소",
            stickers: ["trash.fill", "washer.fill", "bucket.fill"]
        ),
        StickerData(
            category: "건강",
            stickers: ["heart.fill", "figure.walk", "pills.fill", "bed.double.fill"]
        ),
        StickerData(
            category: "미용",
            stickers: ["comb.fill", "face.smiling.fill", "scissors", "paintpalette.fill"]
        ),
        StickerData(
            category: "금융",
            stickers: ["creditcard.fill", "wallet.pass.fill", "banknote.fill", "chart.line.uptrend.xyaxis"]
        ),
        StickerData(
            category: "취미",
            stickers: ["book.fill", "camera.fill", "airplane", "gamecontroller.fill"]
        ),
        StickerData(
            category: "음악",
            stickers: ["music.note", "speaker.wave.3.fill", "guitars", "headphones"]
        )
    ]

    let category: String
    let stickers: [String]
}
