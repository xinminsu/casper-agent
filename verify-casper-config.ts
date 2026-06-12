/**
 * Casper Plugin Configuration Verification Script
 */

import { character } from './src/character.ts';

console.log('=== Casper Plugin Configuration Verification ===\n');

// Check environment variables
const casperEnabled = process.env.CASPER_ENABLED?.trim() === 'true';
console.log(`CASPER_ENABLED environment variable: ${process.env.CASPER_ENABLED || 'Not set'}`);
console.log(`Should plugin load: ${casperEnabled ? 'Yes' : 'No'}\n`);

// Check plugin list
console.log('Configured plugin list:');
character.plugins.forEach((plugin: string, index: number) => {
  const isCasper = plugin.includes('casper');
  const prefix = isCasper ? '>>> ' : '    ';
  const suffix = isCasper ? ' <<< CASPER PLUGIN' : '';
  console.log(`${prefix}${index + 1}. ${plugin}${suffix}`);
});

console.log('\n=== Verification Results ===');
const hasCasperPlugin = character.plugins.some((plugin: string) => plugin.includes('@suxinmin/plugin-casper'));
console.log(`Is @suxinmin/plugin-casper in plugin list: ${hasCasperPlugin ? '✓ Yes' : '✗ No'}`);

if (casperEnabled && !hasCasperPlugin) {
  console.warn('⚠️  Warning: CASPER_ENABLED=true but plugin not found in list');
} else if (!casperEnabled && hasCasperPlugin) {
  console.warn('⚠️  Warning: CASPER_ENABLED not enabled but plugin is in list');
} else if (casperEnabled && hasCasperPlugin) {
  console.log('✓ Configuration correct: Plugin enabled and in list');
} else {
  console.log('✓ Configuration correct: Plugin disabled and not in list');
}

console.log('\nTip: Run "bun install" or "npm install" to install plugin dependencies');
