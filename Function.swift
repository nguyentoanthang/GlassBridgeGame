// Code inside modules can be shared between pages and other source files.
import  Foundation

public func probabilityCal (totalPeople: Int, totalTiles: Int, cells: Int = 2) -> Double {
    
    // calculate pass and fail ratio
    let pass = 1/Double(cells)
    let fail = 1 - pass
    // let cellsFail = cells - 1
    // The minimum people have to survive
    let minSurvivePeople = 1
    // The number of people testing the tiles
    let testedPeople = totalPeople - minSurvivePeople
    // The number of tiles that tested people can test
    let testedTiles = testedPeople / (cells - 1)
    // The remainder cells in titles
    let remainderCells = testedPeople % (cells - 1)
    // The Minimum tiles must be unlocked
    let minTilesUnlock = totalTiles - testedTiles
    
    if minTilesUnlock <= 0 {
        return 1
    }
    
    var probability:Double = 0
    var temp: Double
    
    for i in minTilesUnlock ... totalTiles {
        temp = Double(binomial(n: totalTiles, i))
        temp = temp * pow(pass, Double(i))
        temp = temp * pow(fail,Double((totalTiles - i)))
        
        probability = probability + temp
    }
    
    if remainderCells > 0 {
        // re-calculate the pass ratio for this tiles
        let re_pass = 1/Double(cells - remainderCells)
        
        temp = pow(pass, Double(minTilesUnlock - 1))
        temp = temp * pow(fail, Double(testedTiles))
        temp = temp * re_pass
        
        probability = probability + temp
    }
    
    return probability
}

func binomial(n: Int, _ k: Int) -> Int {
    precondition(k >= 0 && n >= 0)
    if (k > n) { return 0 }
    var result = 1
    for i in 0 ..< min(k, n-k) {
        result = (result * (n - i))/(i + 1)
    }
    return result
}
