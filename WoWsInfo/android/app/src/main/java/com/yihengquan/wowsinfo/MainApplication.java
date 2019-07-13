package com.yihengquan.wowsinfo;

import android.app.Application;

import com.babisoft.ReactNativeLocalization.ReactNativeLocalizationPackage;
import com.corbt.keepawake.KCKeepAwakePackage;
import com.dooboolab.RNIap.RNIapPackage;
import com.facebook.react.ReactApplication;

import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactPackage;
import com.facebook.ads.AudienceNetworkAds;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.soloader.SoLoader;
import com.horcrux.svg.SvgPackage;
import com.masteratul.exceptionhandler.ReactNativeExceptionHandlerPackage;
import com.oblador.vectoricons.VectorIconsPackage;
import com.reactnativecommunity.asyncstorage.AsyncStoragePackage;

import java.util.Arrays;
import java.util.List;

import suraj.tiwari.reactnativefbads.FBAdsPackage;

public class MainApplication extends Application implements ReactApplication {

  private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
    @Override
    public boolean getUseDeveloperSupport() {
      return BuildConfig.DEBUG;
    }

    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
            new ReactNativeExceptionHandlerPackage(),
            new FBAdsPackage(),
            new KCKeepAwakePackage(),
            new AsyncStoragePackage(),
            new RNIapPackage(),
            new SvgPackage(),
            new VectorIconsPackage(),
            new ReactNativeLocalizationPackage()
      );
    }

    @Override
    protected String getJSMainModuleName() {
      return "index";
    }
  };

  @Override
  public ReactNativeHost getReactNativeHost() {
    return mReactNativeHost;
  }

  @Override
  public void onCreate() {
    super.onCreate();
    AudienceNetworkAds.initialize(this);
    SoLoader.init(this, /* native exopackage */ false);
  }
}
