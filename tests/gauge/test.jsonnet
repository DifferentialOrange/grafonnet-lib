local grafana = import 'grafonnet/grafana.libsonnet';
local gauge = grafana.gauge;

{
  basic: gauge.new('single', span=12),
  target:
    gauge.new('targets', span=12)
    .addTarget('target1')
    .addTarget('target2')
    .addTarget('target3')
  ,
  advanced: gauge.new(
    'advanced',
    calc='sum',
    datasource='prom1',
    height='42px',
    span=6,
    time_from='5m',
    transparent=true
  ),
  threshold: gauge.new(
    'threshold',
    calc='mean',
    datasource='mem',
    labels=true,
    markers=false,
    max=95,
    min=10,
    pluginVersion='6.7.3',
  ).addThreshold('green').addThreshold('yellow', 50).addThreshold('red', 80),
}
