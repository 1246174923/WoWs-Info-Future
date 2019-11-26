import { Component } from 'react';
import { WoWsComponent } from './WoWsComponent';
import { Surface, Text } from 'react-native-paper';

export interface ErrorProps {
  message: string
}

class ErrorComponent extends Component<ErrorProps, {}> implements WoWsComponent {
  isProFeature: boolean = false;
  
  constructor(props: ErrorProps) {
    super(props);
  }

  render() {
    return (
      <Surface>
        <Text>{this.props.message}</Text>
      </Surface>
    )
  }
}

export { ErrorComponent };
