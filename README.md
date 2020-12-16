# PointCloudShader
![image](https://user-images.githubusercontent.com/15693656/94855000-cac5c280-0468-11eb-95f6-ea65926e09b6.png)

## Description
点群を描画するシェーダーです。VRChatでの使用を想定しています。

## Usage
1. [Releases](https://github.com/Kuwamai/PointCloudShader/releases)からUnitypackageをダウンロードします
1. Unity projectにUnitypackageをimportします
1. Assets/PointCloudShader/Prefabs/PointCloud.prefabをHierarchieに配置します
1. 点群の大きさはInspectorのSizeで変更できます

## 点群の追加方法
PointCloudShaderは点群データをテクスチャに埋め込んでいます。テクスチャの生成方法は下記記事を参照してください

* [ソーシャルVRに点群を持ち込みたい - クワマイでもできる](https://kuwamai.hatenablog.com/entry/2020/12/17/013711)

## References & Includings
* PointCloud.shaderはPhi16_さんが書いてくださった[pointcloud.shader](https://twitter.com/phi16_/status/1041256230545612800)を一部改変して作成しました
* 点群データ: 渋谷地下3Dデータ ©3D City Experience Lab https://3dcel.com/opendata/
    * Licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/).

## License
This repository is licensed under the MIT license, see [LICENSE](./LICENSE).
