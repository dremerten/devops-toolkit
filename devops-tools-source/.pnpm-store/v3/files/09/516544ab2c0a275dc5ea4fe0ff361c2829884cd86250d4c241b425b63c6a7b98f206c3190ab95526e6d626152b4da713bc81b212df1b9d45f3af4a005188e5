declare type MetadataValue = boolean | string | Date | number;
interface MetadataConfig {
    [key: string]: MetadataValue | MetadataValue[] | MetadataConfig;
}
interface MetadataFlat {
    key: string;
    value: string;
}

declare function generateMeta({ twitter: twitterMetadataRaw, ...ogMetadataRaw }: MetadataConfig, { indentation, indentWith, generateTwitterCompatibleMeta }?: {
    indentation?: number;
    indentWith?: string;
    generateTwitterCompatibleMeta?: boolean;
}): string;

export { MetadataConfig, MetadataFlat, MetadataValue, generateMeta };
