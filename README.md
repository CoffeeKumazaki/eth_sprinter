# eth_sprinter
短距離走選手を育成するゲーム  
選手は生まれながらの才能と、トレーニングによる努力でベストスコアを目指します

# Contractの構成

## SprinterFactory.sol
`Sprinter`の定義と、生成アルゴリズムの実装  

## SprinterTraining.sol
`Sprinter`の育成処理の実装  
無料のセルフトレーニングと、CryptoKittiesとの有料トレーニングを提供  

## SprinterHelper.sol
Webからコントラクトへアクセスするインターフェイスを実装  
`Sprinter`の可変パラメータ変更インターフェイス, オーナーの所持`Sprinter`取得

## SprinterCompetition.sol
`Sprinter`のスコア更新コントラクト  
才能と努力の成果を試せ!  
※タイムを競う予定だったが、小数を扱えないため、短距離走のスコアをどう表現するか検討中...

## SprinterOwnership.sol
`Sprinter`をNon-Fungible Token(NFT)として扱うために`ERC721`を継承  

