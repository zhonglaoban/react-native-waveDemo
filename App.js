/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, Button, NativeModules} from 'react-native';
import WaterView from './WaterView';
import PPTView from './PPTView';

const pptViewManager = NativeModules.PPTViewManager;
const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

type Props = {};
export default class App extends Component<Props> {
  drawLine = () => {
    let points = [];
    for(let i=0; i < 10; i++) {
      let x = Math.floor(Math.random()*300)
      let y = Math.floor(Math.random()*400)
      let point = {x:x, y:y}
      points.push(point)
    }
    pptViewManager.drawLines(points, 1, {r:123, g:213, b:132, a:1})
  }
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
        <PPTView style={{width:300, height:400}}/>
        <Button onPress={this.drawLine} title="画线"/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
