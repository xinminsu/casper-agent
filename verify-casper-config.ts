/**
 * 验证 Casper 插件配置的测试脚本
 */

import { character } from './src/character.ts';

console.log('=== Casper 插件配置验证 ===\n');

// 检查环境变量
const casperEnabled = process.env.CASPER_ENABLED?.trim() === 'true';
console.log(`CASPER_ENABLED 环境变量: ${process.env.CASPER_ENABLED || '未设置'}`);
console.log(`插件是否应该加载: ${casperEnabled ? '是' : '否'}\n`);

// 检查插件列表
console.log('已配置的插件列表:');
character.plugins.forEach((plugin: string, index: number) => {
  const isCasper = plugin.includes('casper');
  const prefix = isCasper ? '>>> ' : '    ';
  const suffix = isCasper ? ' <<< CASPER PLUGIN' : '';
  console.log(`${prefix}${index + 1}. ${plugin}${suffix}`);
});

console.log('\n=== 验证结果 ===');
const hasCasperPlugin = character.plugins.some((plugin: string) => plugin.includes('@suxinmin/plugin-casper'));
console.log(`@suxinmin/plugin-casper 是否在插件列表中: ${hasCasperPlugin ? '✓ 是' : '✗ 否'}`);

if (casperEnabled && !hasCasperPlugin) {
  console.warn('⚠️  警告: CASPER_ENABLED=true 但插件未在列表中找到');
} else if (!casperEnabled && hasCasperPlugin) {
  console.warn('⚠️  警告: CASPER_ENABLED 未启用但插件在列表中');
} else if (casperEnabled && hasCasperPlugin) {
  console.log('✓ 配置正确: 插件已启用并在列表中');
} else {
  console.log('✓ 配置正确: 插件已禁用且不在列表中');
}

console.log('\n提示: 运行 "bun install" 或 "npm install" 来安装插件依赖');
