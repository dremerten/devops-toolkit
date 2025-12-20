export function computeBuildVersion(baseVersion: string, buildNumber?: string | number) {
  const build = Number.parseInt(String(buildNumber ?? '0'), 10);
  if (Number.isNaN(build) || build <= 0) {
    return baseVersion;
  }

  const [majorStr, minorStr, patchStr = '0'] = baseVersion.split('.');
  const major = Number(majorStr);
  const minor = Number(minorStr);
  const patch = Number(patchStr);

  if ([major, minor, patch].some(Number.isNaN)) {
    return baseVersion;
  }

  const totalPatch = patch + build;
  const bumpedMinor = minor + Math.floor(totalPatch / 10);
  const nextPatch = totalPatch % 10;

  return `${major}.${bumpedMinor}.${nextPatch}`;
}
