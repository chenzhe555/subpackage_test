import React from 'react';
import { View, Text, Image } from 'react-native';

export default class GoodsDetailMainVC extends React.Component {
  constructor(props) {
    super(props);
    console.log('加载了 商品详情 111 ...');
  }

  render() {
    return (
      <View style={{ marginTop: 100 }}>
        <Text>GoodsDetailMainVC</Text>
        <Image source={require('../assets/images/package_self_lifting.png')} style={[{width: 16, height: 16, marginTop: 50}]}/>
      </View>
    )
  }
}
