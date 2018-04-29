self: super:

let
  callPackage = self.callPackage;
in
{
  shofel2 = (callPackage ./shofel2 {});
  imx-usb-loader = (callPackage ./imx-usb-loader {});
  fusee-launcher = (callPackage ./fusee-launcher {});
}
