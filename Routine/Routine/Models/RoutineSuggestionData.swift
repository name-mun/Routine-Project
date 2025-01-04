//
//  RoutineSuggestionData.swift
//  Routine
//
//  Created by mun on 11/17/24.
//
//
// 섹션 제목
// 섹션 부제목
// 섹션별 아잍템(제목, 아이콘, 배경색)

import Foundation

struct SuggestionData {

    static let mock: [SuggestionData] = [
        SuggestionData(
            sectionTitle: "미라클 모닝",
            subTitle: "하루의 시작을 상쾌하게 시작하세요.",
            routineSuggestionData: [
                RoutineData(
                    title: "침구류 정리",
                    color: .ivory,
                    sticker: "bed.double.fill",
                    repeatation: .default),
                RoutineData(
                    title: "물 한컵 마시기",
                    color: .mintGreen,
                    sticker: "cup.and.saucer.fill",
                    repeatation: .default),
                RoutineData(
                    title: "모닝 커피 한잔",
                    color: .pastelPeach,
                    sticker: "takeoutbag.and.cup.and.straw.fill",
                    repeatation: .default),
                RoutineData(
                    title: "아침 운동하기",
                    color: .pastelGreen,
                    sticker: "figure.walk",
                    repeatation: .default)
            ]),
        SuggestionData(
            sectionTitle: "깨끗한 집",
            subTitle: "깨끗한 집만큼 뿌듯한게 없어요.",
            routineSuggestionData: [
                RoutineData(
                    title: "먼지 제거",
                    color: .lightAqua,
                    sticker: "star.fill",
                    repeatation: .default),
                RoutineData(
                    title: "세탁 하기",
                    color: .pastelGreen,
                    sticker: "washer.fill",
                    repeatation: .default),
                RoutineData(
                    title: "화분 물주기",
                    color: .softIvory,
                    sticker: "pawprint.fill",
                    repeatation: .default),
                RoutineData(
                    title: "쓰레기 버리기",
                    color: .pastelYellow,
                    sticker: "trash.fill",
                    repeatation: .default)
            ]),
        SuggestionData(
            sectionTitle: "성장하는 나",
            subTitle: "나를 채우는 시간",
            routineSuggestionData: [
                RoutineData(
                    title: "하루 10분 독서",
                    color: .lilac,
                    sticker: "book.fill",
                    repeatation: .default),
                RoutineData(
                    title: "다이어리 쓰기",
                    color: .pastelYellow,
                    sticker: "calendar",
                    repeatation: .default),
                RoutineData(
                    title: "등교 하기",
                    color: .white,
                    sticker: "person.fill",
                    repeatation: .default),
                RoutineData(
                    title: "새로운 기술 배우기",
                    color: .softAqua,
                    sticker: "lightbulb.fill",
                    repeatation: .default)
            ])
    ]


    var sectionTitle: String
    var subTitle: String
    var routineSuggestionData: [RoutineData]
}


