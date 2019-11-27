/**
 * ProviderForAll.tsx
 * This is a provider for everything (including theme, language and anything that needs to rerender the entire app)
 */

import React, { Component, ReactNode } from 'react';
import { Provider as PaperProvider } from 'react-native-paper';
import CustomTheme from '../../core/model/CustomTheme';

interface AllProps {
  children: ReactNode
}

interface AllState {
  theme: CustomTheme,
  updateTheme(theme: CustomTheme): void,
};

/// Export for other components
const ContextForAll =  React.createContext<AllState|null>(null);

class ProviderForAll extends Component<AllProps, AllState> {
  constructor(props: AllProps) {
    super(props);

    this.state = {
      // Theme and updateTheme from anywhere
      theme: new CustomTheme(true, '#123456'),
      updateTheme: (newTheme) => {
        this.setState({
          theme: newTheme
        });
      }
    }
  }

  render() {
    const { children } = this.props;
    const { theme } = this.state;

    // Wrap around paper provider
    return (
      <ContextForAll.Provider value={this.state}>
        <PaperProvider theme={theme.getTheme()}>
          { children }
        </PaperProvider>
      </ContextForAll.Provider>
    );
  }
}

const ConsumerForAll = ContextForAll.Consumer;
export { ContextForAll, ConsumerForAll, ProviderForAll };
