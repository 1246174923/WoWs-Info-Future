/**
 * @format
 */

import 'react-native';
import React from 'react';
import { AppLogo, ContainedButton, ErrorComponent, LoadingIndicator, ProviderForAll } from '../../src/ui/component';

// Note: test renderer must be required after react-native.
import renderer from 'react-test-renderer';

it('AppLogo renders correctly', () => {
  renderer.create(<AppLogo />);
});

it('ContainedButton renders correctly', () => {
    renderer.create(<ContainedButton>Hello World</ContainedButton>);
});

it('ErrorComponent renders correctly', () => {
    renderer.create(<ErrorComponent message='Nothing' />);
});

it('LoadingIndicator renders correctly', () => {
    renderer.create(<LoadingIndicator />);
});

// Provider for all is a bit different
