import React, { Component } from 'react';
import { View } from 'react-native';
import { styles } from './SearchSegmentStyle';
import SegmentedControlTab from 'react-native-segmented-control-tab';
import strings from '../../localization';

class SearchSegment extends Component {
  render() {
    const { containerStyle, activeStyle, viewStyle, textStyle } = styles;
    const { tabPress, selectedIndex } = this.props;
    return (
      <View style={viewStyle}>
        <SegmentedControlTab tabsContainerStyle={containerStyle} tabStyle={{backgroundColor: global.themeColour, borderColor: 'white'}} 
          activeTabStyle={activeStyle} tabTextStyle={textStyle} activeTabTextStyle={{color: global.themeColour}} borderRadius={13} 
          values={[strings.search_player, strings.search_clan]} onTabPress={tabPress} selectedIndex={selectedIndex} />
      </View>
    )
  }
}

export {SearchSegment};