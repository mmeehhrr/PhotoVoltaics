within PhotoVoltaics.Components.Converters;
model DCConverter "DC controlled single phase DC/AC converter"
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  extends .PhotoVoltaics.Icons.Converter;

  parameter Modelica.SIunits.Voltage VRef=48
    "Reference DC source voltage";
  parameter Modelica.SIunits.Time Ti=1E-6
    "Internal integration time constant";
  Modelica.Blocks.Interfaces.RealInput vDCRef(final unit = "V") "DC voltage" annotation (
    Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin={-60,-120}),  iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin={-60,-120})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, 0})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin={-90,36})));
  Modelica.Blocks.Math.Product product annotation (
    Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
  Modelica.Blocks.Math.Feedback feedback annotation (
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-30, 0})));
  Modelica.Electrical.Analog.Sources.SignalCurrent            variableCurrentSource annotation (
    Placement(transformation(extent={{-10,-10},{10,10}},      rotation = 90, origin={80,-40})));
  Modelica.Electrical.Analog.Sensors.PowerSensor                      powerSensor annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={80,-10})));
  Modelica.Blocks.Continuous.Integrator integrator(k=1/VRef/Ti)      annotation (
    Placement(transformation(extent={{-8,-50},{12,-30}})));
  Modelica.Blocks.Math.Gain gain(final k = -1) annotation (
    Placement(transformation(extent={{-10,-10},{10,10}},      rotation=180,   origin={0,0})));

equation
  connect(currentSensor.n, signalVoltage.p) annotation (Line(points={{-90,26},{-90,26},{-90,10}},        color = {0, 0, 255}));
  connect(signalVoltage.v, vDCRef) annotation (Line(points={{-78,0},{-70,0},{-70,-80},{-60,-80},{-60,-120}},        color = {0, 0, 127}));
  connect(currentSensor.i, product.u1) annotation (Line(points={{-79,36},{-79,36},{-70,36},{-62,36}},                     color = {0, 0, 127}));
  connect(vDCRef, product.u2) annotation (Line(points={{-60,-120},{-60,-120},{-60,-88},{-60,-94},{-60,-80},{-70,-80},{-70,24},{-62,24}},        color = {0, 0, 127}));
  connect(product.y, feedback.u1) annotation (Line(points = {{-39, 30}, {-30, 30}, {-30, 8}}, color = {0, 0, 127}));
  connect(feedback.y, integrator.u) annotation (Line(points={{-30,-9},{-30,-9},{-30,-20},{-30,-40},{-10,-40}},           color = {0, 0, 127}));
  connect(gain.y, feedback.u2) annotation (Line(points={{-11,1.33227e-15},{-21,1.33227e-15},{-21,0},{-10,0},{-22,0}}, color = {0, 0, 127}));
  connect(gain.u, powerSensor.power) annotation (Line(points={{12,-1.33227e-15},{12,0},{40,0},{60,0},{60,1.77636e-15},{69,1.77636e-15}},
                                                                                                                       color={0,0,127}));
  connect(powerSensor.nc, variableCurrentSource.n) annotation (Line(points={{80,-20},{80,-30}},color={0,0,255}));
  connect(integrator.y, variableCurrentSource.i) annotation (Line(points={{13,-40},{68,-40},{68,-40}}, color={0,0,127}));
  connect(powerSensor.pv, powerSensor.pc) annotation (Line(points={{90,-10},{90,-10},{90,0},{80,0}},    color={0,0,255}));
  connect(currentSensor.p, dc_p1) annotation (Line(points={{-90,46},{-90,46},{-90,60},{-100,60}}, color={0,0,255}));
  connect(signalVoltage.n, dc_n1) annotation (Line(points={{-90,-10},{-90,-10},{-90,-60},{-100,-60}}, color={0,0,255}));
  connect(powerSensor.pc, dc_p2) annotation (Line(points={{80,0},{80,60},{100,60}}, color={0,0,255}));
  connect(variableCurrentSource.p, dc_n2) annotation (Line(points={{80,-50},{80,-50},{80,-58},{80,-58},{80,-60},{100,-60}}, color={0,0,255}));
  connect(dc_n2, powerSensor.nv) annotation (Line(points={{100,-60},{90,-60},{60,-60},{60,-26},{60,-10},{70,-10}}, color={0,0,255}));
  annotation (
    defaultComponentName = "converter",
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={                                                                                                                                                                 Text(extent={{-100,40},{-40,-40}},      lineColor = {0, 0, 255}, textString = "="),                                                                                   Text(extent = {{-150, 150}, {150, 110}}, lineColor = {0, 0, 255}, textString = "%name"), Text(extent={{-150,-110},{-90,-150}},   lineColor = {0, 0, 255}, pattern = LinePattern.Dash, fillColor = {0, 0, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "vDCRef"), Text(extent={{-80,90},{20,50}},      lineColor={0,0,255},     pattern=LinePattern.Dash,   fillColor={0,0,255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
          textString="PV"),                                                                                                                                                                                                        Text(extent={{-40,-50},{60,-90}},      lineColor={0,0,255},     pattern=LinePattern.Dash,   fillColor={0,0,255},
            fillPattern=
              FillPattern.Solid,
          textString="bat"),                                                                                                                                                                                                        Text(extent={{40,40},{100,-40}},        lineColor = {0, 0, 255}, textString = "=")}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html>
<p>This is an ideal DC/DC converter.</p>
<p>
The DC/DC converter is characterized by:
</p>
<ul>
<li>Losses are not considered</li>
<li>The AC output current is determined based on power balance, calculating with instantaneous values:
    <code>vDC1*iDC1 + vDC2*iDC2 = 0<code></li>
<li>The DC input voltage <code>vDCRef</code> is applied to the DC side 1 without limitations</li>
<li>The phase angle input <code>phi</code> influences the AC reactive power based on the following figure,
    where underlined voltages and currents represent complex phasors</li>
</ul>
</html>"));
end DCConverter;
