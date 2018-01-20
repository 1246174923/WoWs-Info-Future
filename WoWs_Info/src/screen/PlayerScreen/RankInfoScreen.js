import React from 'react';
import { Text, SafeAreaView } from 'react-native';
import { WoWsLoading, RankCell, NoInformation } from '../../component';
import GridView from 'react-native-super-grid';
import { RankInfo } from '../../core';
import strings from '../../localization';

class RankInfoScreen extends React.PureComponent {
  state = {
    isReady: false,
    rank: [],
    ship: {},
  }

  async componentWillMount() {
    const { id, playerName, server } = this.props;
    let rank = new RankInfo(id, server);
    let rankInfo = await rank.getRankInfo();
    let shipInfo = await rank.getRankShipInfo();
    this.setState({
      isReady: true,
      rank: rankInfo,
      ship: shipInfo,
    })
  }

  render() {
    const { isReady, rank, ship } = this.state;
    if (isReady) {
      if (rank) {
        return (
          <SafeAreaView>
            <GridView itemDimension={300} items={rank} renderHeader={this.renderHeader} enableEmptySections
              automaticallyAdjustContentInsets={false} renderItem={item => <RankCell rank={item} ship={ship}/>} />
          </SafeAreaView>
        )
      } else return <NoInformation />
    } else return <WoWsLoading />
  }
}

export {RankInfoScreen};