import UIKit

// MARK: - SnakeFlowLayout

final class SnakeFlowLayout: UICollectionViewFlowLayout {
  
  private var cachedAttributes: [UICollectionViewLayoutAttributes] = []
  
  override func prepare() {
    super.prepare()
    
    //자신의 컬렉션 뷰를 확인
    guard let collectionView = collectionView else { return }
    
    //처음 시작시 캐시된 속성들에 대해서 리셋
    cachedAttributes.removeAll()
    
    // 한 행에 들어갈 아이템 개수 계산 -> 가능한 너비 계산? sectionInset을 통한 여백을 통해 총 너비 계산?
    let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right
    
    // 한 줄의 최대 셀 갯수 = (최대 너비 + 셀 간 최소 간격) / (아이템 너비 + 셀 간 최소 간격)
    //-> 마지막 셀의 경우 하나 생략되기 때문 / 하지만 오차 발생 가능
    let maxNumColumns = Int((availableWidth + minimumInteritemSpacing) / (itemSize.width + minimumInteritemSpacing))
    
    //1번째 섹션에 대한 아이템의 수?
    let numberOfItems = collectionView.numberOfItems(inSection: 0)
    
    //offSet? -> 시작 (x,y) 좌표
    var xOffset: CGFloat = sectionInset.left
    var yOffset: CGFloat = sectionInset.top
    
    // 현재 행에 대해 저장 -> 이후 반복문에서 수정됨
    var currentRow = 0
    
    // 섹션의 아이템 수를 통한 반복문
    for item in 0..<numberOfItems {
      //0번 섹션의 item 번째 indexPath 생성
      let indexPath = IndexPath(item: item, section: 0)
      
      //indexPath에 대한 컬렉션 뷰 레이아웃 속성 객체 생성
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      
      
      // 현재 행의 시작 인덱스와 마지막 인덱스 계산
      let startIndexOfRow = currentRow * maxNumColumns
      let isReversedRow = currentRow % 2 == 1
      
      // x 오프셋 계산
      if isReversedRow {
        // 홀수 행의 경우 오른쪽에서 왼쪽으로
        let itemInRow = item - startIndexOfRow
        xOffset = collectionView.bounds.width - sectionInset.right - CGFloat(itemInRow + 1) * (itemSize.width + minimumInteritemSpacing)
      } else {
        // 짝수 행의 경우 왼쪽에서 오른쪽으로
        let itemInRow = item - startIndexOfRow
        xOffset = sectionInset.left + CGFloat(itemInRow) * (itemSize.width + minimumInteritemSpacing)
      }
      
      // attributes를 통해 좌표 반환
      attributes.frame = CGRect(x: xOffset,
                                y: yOffset,
                                width: itemSize.width,
                                height: itemSize.height)
      
      cachedAttributes.append(attributes)
      
      // 다음 행으로 이동해야 하는지 확인
      if (item + 1) % maxNumColumns == 0 {
        currentRow += 1
        yOffset += itemSize.height + minimumLineSpacing
      }
    }
  }
  
//  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return cachedAttributes.filter { rect.intersects($0.frame) }
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cachedAttributes[indexPath.item]
  }
  
  override var collectionViewContentSize: CGSize {
    guard let collectionView = collectionView else { return .zero }
    let numberOfItems = collectionView.numberOfItems(inSection: 0)
    
    guard numberOfItems > 0 else { return .zero }
    
    let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right
    let maxNumColumns = Int((availableWidth + minimumInteritemSpacing) / (itemSize.width + minimumInteritemSpacing))
    
    let numberOfRows = Int(ceil(Float(numberOfItems) / Float(maxNumColumns)))
    let height = sectionInset.top + sectionInset.bottom + CGFloat(numberOfRows) * itemSize.height + CGFloat(max(0, numberOfRows - 1)) * minimumLineSpacing
    
    return CGSize(width: collectionView.bounds.width, height: height)
  }
}


#Preview("MainRoutineViewController") {
  MainRoutineViewController()
}
