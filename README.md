# Highrise

Highrise is a Bash shell script for generating super-resolution images from a stack of lower-resolution photos. Script is based on [https://github.com/pixlsus/Scripts/tree/master/superres](https://github.com/pixlsus/Scripts/tree/master/superres).

# Dependencies

- ImageMagic
- Hugin
- ExifTool

To install the required packages on openSUSE, use the following command:

    sudo zypper in ImageMagick hugin exiftool

## Installation

```
git clone https://github.com/dmpop/highrise.git
cd highrise
sudo cp highrise.sh /usr/local/bin/highrise
sudo chown root:root /usr/local/bin/highrise
sudo chmod 755 /usr/local/bin/highrise
```

## Prepare Source Photos

1. Set your camera to continuous shooting
2. Disable optical stabilization and shoot hand-held
3. Take between 8 and 15 photos

Keep in mind that Highrise works best with photos of static subjects.

## Usage

    highrise -e [EXT] -d [DIR]

Replace `[EXT]` with the file extension of the source photos (e.g., *JPG* or *jpg*) and `[DIR]` with the absolute path to the directory containing source photos.

## Problems?

Please report bugs and issues in the [Issues](https://github.com/dmpop/highrise/issues) section.

## Contribute

If you've found a bug or have a suggestion for improvement, open an issue in the [Issues](https://github.com/dmpop/highrise/issues) section.

To add a new feature or fix issues yourself, follow the steps below.

1. Fork the project's repository repository
2. Create a feature branch using the `git checkout -b new-feature` command
3. Add your new feature or fix bugs and run the `git commit -am 'Add a new feature'` command to commit changes
4. Push changes using the `git push origin new-feature` command
5. Submit a pull request

## Author

Dmitri Popov [dmpop@linux.com](mailto:dmpop@linux.com)

## License

The [GNU General Public License version 3](http://www.gnu.org/licenses/gpl-3.0.en.html)

## Linux Photography

Highrise is a part of a streamlined and automated Linux-based photographic workflow described in the [Linux Photography](https://gumroad.com/l/linux-photography) book. Get your copy at [Google Play Store](https://play.google.com/store/books/details/Dmitri_Popov_Linux_Photography?id=cO70CwAAQBAJ) or [Gumroad](https://gumroad.com/l/linux-photography).

<img src="https://scribblesandsnaps.files.wordpress.com/2016/07/linux-photography-6.jpg" width="200"/>
