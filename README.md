# ChangeAspectRatio


## Introduce

The purpose of this project is changing the aspect ratio of NES/SNES Virtual Console for WiiU.

The default aspect ratio of NES/SNES Virtual Console for WiiU is 4:3.

But the original resolution of NES/SNES is 256x224, it means the original aspect ratio is 8:7.

The resolution of WiiU GamePad is 854x480 and the TV is 1920x1080, it means that the aspect ratio of the display device for WiiU is 16:9.

So the NES/SNES Virtual Console can't display in perfect pixel mode, and it also can't display full screen on the TV and GamePad, it has big black bars on the sides.

So if we can change the aspect ratio to 8:7, it will be perfect pixel. if we change the aspect ratio to 16:9, it will be full screen.

## Usage

1. Decrypt the WUP files to Loadiine files by CDecrypt.exe

2. Decompress the code/WUP_XXXX.rpx

```command
wiiurpxtool.exe -d WUP_XXXX.rpx
```

3. Change the aspect ratio to 8:7

```command
ChangeAspectRatio.exe WUP_XXXX.rpx
```

    or to 16:9

```command
ChangeAspectRatio.exe WUP_XXXX.rpx -w
```

> Notice: `-w`  parameter must be the second parameter.

4. Compress the code/WUP_XXXX.rpx

```command
wiiurpxtool.exe -c WUP_XXXX.rpx
```

5. Repack the Loadiine files to WUP files by NUSPacker.

6. Install your new WUP package.

7. Enjoy it.

The easy way to do the above steps is using the bat file. I have already written the bat files. look at the example directory.

## Reference

https://gbatemp.net/threads/understanding-and-changing-snes-vc-rpx-settings.425474/