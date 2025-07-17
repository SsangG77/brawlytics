//
//  PlayerProfileUseCase.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import RxSwift


protocol PlayerProfileUseCase {
    func fetchUserProfile() -> Observable<UserTrophyModel>
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]>
    func groupByRole(brawlers: [BrawlerTrophyModel]) -> [Role: [BrawlerTrophyModel]]
    
}

class PlayerProfileUseCaseImpl: PlayerProfileUseCase {
    
    private let roleToNames: [Role: [String]] = [
            .tanker: ["BULL", "EL PRIMO", "ROSA", "DARRYL", "JACKEY", "FRANK", "BIBI", "ASH", "HANK", "BUSTER", "OLLIE", "MEG", "DRACO"],
            .assassin: ["STU", "EDGAR", "SAM", "SHADE", "MORTIS", "BUZZ", "FANG", "MICO", "MELODIE", "LILY", "CROW", "LEON", "CORDELIUS", "KENJI", "KAZE", "ALLI"],
            .supporter: ["POCO", "GUS", "PAM", "BERRY", "MAX", "BYRON", "RUFFS", "GRAY", "DOUG", "KIT", "JAE-YONG"],
            .controller: ["JESSIE", "PENNY", "BO", "EMZ", "GRIFF", "GALE", "MEEPLE", "GENE", "MR. P", "SQUEAK", "LOU", "OTIS", "WILLOW", "CHUCK", "CHARLIE", "SANDY", "AMBER", "FINX"],
            .damageDealer: ["SHELLY", "NITA", "COLT", "8-BIT", "RICO", "CARL", "COLETTE", "LOLA", "PEARL", "TARA", "EVE", "R-T", "CLANCY", "MOE", "SPIKE", "SURGE", "CHESTER", "LUMI"],
            .marksmen: ["BROCK", "NANI", "MANDY", "MAISIE", "BELLE", "BONNIE", "BEA", "ANGELO", "JANET", "PIPER"],
            .thrower: ["BARLEY", "DYNAMIK", "TICK", "GROM", "LARRY & LAWRIE", "SPROUT", "JUJU"]
       ]
    
    private let repository: PlayerProfileRepository
    
    init(repository: PlayerProfileRepository) {
        self.repository = repository
    }
    
    func fetchUserProfile() -> Observable<UserTrophyModel> {
        return repository.fetchUserProfile()
    }
    
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]> {
        return repository.fetchBrawlersTrophy()
    }
    
    func groupByRole(brawlers: [BrawlerTrophyModel]) -> [Role: [BrawlerTrophyModel]] {
        var result: [Role: [BrawlerTrophyModel]] = [:]
        for (role, names) in roleToNames {
            result[role] = brawlers.filter { names.contains($0.name) }
        }
        return result
    }
    
    
    
    
}
