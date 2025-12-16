import { Preset } from 'unocss';

interface PresetScrollbarDefaultOption {
    /**
     * default scrollbar width
     * @default '8px'
     */
    scrollbarWidth?: string;
    /**
     * default scrollbar height
     * @default '8px'
     */
    scrollbarHeight?: string;
    /**
     * default scrollbar track radius
     * @default '4px'
     */
    scrollbarTrackRadius?: string;
    /**
     * default scrollbar thumb radius
     * @default '4px'
     */
    scrollbarThumbRadius?: string;
    /**
     * default scrollbar track background color
     * @default '#f5f5f5'
     */
    scrollbarTrackColor?: string;
    /**
     * default scrollbar thumb background color
     * @default '#ddd'
     */
    scrollbarThumbColor?: string;
    /**
     * css variable prefix
     * @default ''
     */
    varPrefix?: string;
    /**
     * convert number to unit
     * @default value => `${value / 4}rem`
     * @example
     * numberToUnit: value => `${value / 4}rem`
     * p-4 => padding: 1rem
     * p-4px => padding: 4px
     *
     * @example
     * numberToUnit: value => `${value}rpx`
     * p-4 => padding: 4rpx
     */
    numberToUnit?: (value: number) => string;
}
declare function presetScrollbar(option?: PresetScrollbarDefaultOption): Preset;

export { PresetScrollbarDefaultOption, presetScrollbar };
