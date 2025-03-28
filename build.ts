import { type Build } from 'xbuild';

const build: Build = {
    common: {
        project: 'libxml2',
        archs: ['x64'],
        variables: [],
        copy: {},
        defines: [],
        options: [
            ['BUILD_SHARED_LIBS', false],
            ['LIBXML2_WITH_ICONV', false],
            ['LIBXML2_WITH_PROGRAMS', false],
            ['LIBXML2_WITH_TESTS', false],
            ['LIBXML2_WITH_PYTHON', false],
        ],
        subdirectories: ['libxml2'],
        libraries: {
            LibXml2: {
                name: 'libxml2',
                properties: {
                    'DEBUG_POSTFIX': '_d',
                    'RELEASE_POSTFIX': '""',
                }
            },
        },
        buildDir: 'build',
        buildOutDir: '../libs',
        buildFlags: []
    },
    platforms: {
        win32: {
            windows: {},
            android: {
                archs: ['x86', 'x86_64', 'armeabi-v7a', 'arm64-v8a'],
            }
        },
        linux: {
            linux: {}
        },
        darwin: {
            macos: {}
        }
    }
}

export default build;