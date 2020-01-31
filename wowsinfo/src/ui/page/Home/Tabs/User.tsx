import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, Headline, Title, Button, IconButton, Colors, Caption, Divider, Appbar } from 'react-native-paper';
import { ConsumerForAll } from '../../../component';

export interface UserProps {

}

interface UserState {

}

/**
 * User Class
 */
class User extends Component<UserProps, UserState> {
  constructor(props: UserProps) {
    super(props);
  }

  render() {
    const { container, buttonView, userView, greetingText, divider, userText } = styles;
    return (
      <View style={container}>
        { this.renderHeader() }
        <View style={userView}>
          <Headline style={greetingText}>Welcome Back</Headline>
          <Divider style={divider} />
          <Title style={userText}>HenryQuan</Title>
        </View>
        <View style={buttonView}>
          <Button onPress={() => null} mode='contained'>Check my statistics</Button>
          <Button onPress={() => null}>Check latest news</Button>
        </View>
      </View>
    );
  }

  renderHeader() {
    const { titleView, titleTextView } = styles;
    return (
      <ConsumerForAll>
        { c => 
          <Appbar.Header>
            <View style={titleView}>
              <IconButton icon={require('../../../../assets/Logo.png')}
                size={48} color='white' style={{margin: -4}}/>
              <View style={titleTextView}>
                <Title>WoWs Info RE</Title>
                <Caption>1.1.0 (0.9.0.0)</Caption>
              </View>
              <IconButton icon='settings' onPress={() => null}
                size={24} color='white' />
            </View>
          </Appbar.Header>
        }
      </ConsumerForAll>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  titleView: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  titleTextView: {
    flex: 1,
    alignItems: 'center'
  },
  userView: {
    width: '100%',
  },
  divider: {
    marginVertical: 8,
    marginHorizontal: -32
  },
  greetingText: {
    fontSize: 24,
    textAlign: 'center',
  },
  userText: {
    fontSize: 30,
    textAlign: 'center',
  },
  buttonView: {
    width: '61.8%',
    maxWidth: 300,
    margin: 24
  }
});

export { User };
