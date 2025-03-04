within PhotoVoltaics_TGM;
model TGM_Comax_Analytical_2016 "Analytical sun model over the year 2016; Comax modules at TGM building in Vienna, Austria"
  extends Modelica.Icons.Example;
  parameter Integer nsModule = 6 "Number of series connected modules";
  parameter Integer npModule = 1 "Number of parallel connected modules";
  parameter String csvFileName = "TGM_Comax_Analytical_2016_energy.csv";
  PhotoVoltaics.Components.SimplePhotoVoltaics.SimplePlantSymmetric plant(
    useConstantIrradiance=false,
    moduleData=moduleData,
    npModule=npModule,
    nsModule=nsModule) annotation (Placement(visible=true, transformation(
        origin={-50,-10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter PhotoVoltaics.Records.TSM_200_DC01A moduleData annotation (
    Placement(transformation(extent = {{60, 60}, {80, 80}})));
  PhotoVoltaics.Components.Converters.QuasiStationarySinglePhaseConverter converter annotation (
    Placement(transformation(extent = {{10, -20}, {30, 0}})));
  PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(VmpRef = nsModule * moduleData.VmpRef, ImpRef = npModule * moduleData.ImpRef, samplePeriod = 10) annotation (
    Placement(transformation(extent = {{-10, -70}, {10, -50}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundAC
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource
    voltageSource(
    f=50,
    V=230,
    phi=0,
    gamma(start=0, fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-10})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation (
    Placement(transformation(extent = {{-30, 0}, {-10, 20}})));
  Modelica.Blocks.Continuous.Integrator integrator(y(unit = "J")) annotation (
    Placement(transformation(extent = {{-50, -70}, {-70, -50}})));
  PhotoVoltaics.Sources.Irradiance.Irradiance irradiance(startDay = 1, startMonth = 1) annotation (
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PhotoVoltaics_TGM.WriteCSV writeCSV(inputQuantity = "energy(Ws)", fileName = csvFileName) annotation (
    Placement(transformation(extent = {{-80, -70}, {-100, -50}})));
equation
  connect(ground.p, plant.n) annotation (
    Line(points = {{-50, -30}, {-50, -20}}, color = {0, 0, 255}));
  connect(mpTracker.vRef, converter.vDCRef) annotation (
    Line(points={{11,-60},{14,-60},{14,-22}},        color = {0, 0, 127}));
  connect(converter.ac_n, groundAC.pin) annotation (
    Line(points = {{30, -20}, {30, -30}, {70, -30}}, color = {85, 170, 255}));
  connect(groundAC.pin, voltageSource.pin_n) annotation (
    Line(points = {{70, -30}, {70, -30}, {70, -20}}, color = {85, 170, 255}));
  connect(powerSensor.nc, converter.dc_p) annotation (
    Line(points={{-10,10},{-10,10},{10,10},{10,-4}},         color = {0, 0, 255}));
  connect(mpTracker.power, powerSensor.power) annotation (
    Line(points={{-12,-60},{-12,-60},{-30,-60},{-30,-1}},          color = {0, 0, 127}));
  connect(powerSensor.pc, powerSensor.pv) annotation (
    Line(points = {{-30, 10}, {-30, 20}, {-20, 20}}, color = {0, 0, 255}));
  connect(converter.ac_p, voltageSource.pin_p) annotation (
    Line(points = {{30, 0}, {30, 0}, {30, 10}, {70, 10}, {70, 0}}, color = {85, 170, 255}));
  connect(plant.p, powerSensor.pc) annotation (
    Line(points = {{-50, 0}, {-50, 10}, {-30, 10}}, color = {0, 0, 255}));
  connect(powerSensor.nv, ground.p) annotation (
    Line(points = {{-20, 0}, {-20, 0}, {-20, -24}, {-20, -30}, {-50, -30}}, color = {0, 0, 255}));
  connect(ground.p, converter.dc_n) annotation (
    Line(points={{-50,-30},{10,-30},{10,-16}},        color = {0, 0, 255}));
  connect(integrator.u, powerSensor.power) annotation (
    Line(points={{-48,-60},{-48,-60},{-30,-60},{-30,-1}},          color = {0, 0, 127}));
  connect(irradiance.irradiance, plant.variableIrradiance) annotation (
    Line(points = {{-79, -10}, {-62, -10}}, color = {0, 0, 127}));
  connect(writeCSV.u, integrator.y) annotation (
    Line(points = {{-78, -60}, {-71, -60}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 3.1536e+07, Interval = 900, Tolerance = 1e-06, StartTime = 0),
    Documentation(revisions = "<html>
</html>",
        info="<html>
<p>This example is based on analytical solar data for one year. This simulation investigates the theoretical
harvest of electric energy if there were absolutely no clouds and other disturbing weather conditions.</p>
</html>"),
__OpenModelica_simulationFlags(cpu = "()", jacobian = "coloredNumerical", s = "dassl", lv = "LOG_STATS"));
end TGM_Comax_Analytical_2016;
