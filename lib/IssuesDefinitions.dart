class IssuesDefinitions {
  /*
  String gunPolicyLogo = 'assets/gunPolicyPogo.jpeg';
  String climateLogo = 'assets/climatePogo.jpg';
  String educationLogo = 'assets/educationPogo.jpeg';
  String marijuanaLogo = 'assets/marijuana.png';
  String healthcareLogo = 'assets/healthcarePogo.jpg';
  String housingLogo = 'assets/housingPogo.jpg';
  String economyLogo = 'assets/economyPogo.jpg';
  String immigrationLogo = 'assets/immigrationPogo.jpg';
  String policingLogo = 'assets/policingPogo.jpg';
  String reproductiveHealthLogo = 'assets/reproductiveHealthPogo.jpg';
  String issueNameOne = 'GUN POLICY';
  String issueNameTwo = 'CLIMATE CHANGE';
  String issueNameThree = 'EDUCATION';
  String issueNameFour = 'DRUG POLICY';
  String issueNameFive = 'HEALTHCARE';
  String issueNameSix = 'HOUSING';
  String issueNameSeven = 'ECONOMY';
  String issueNameEight = 'IMMIGRATION';
  String issueNameNine = 'POLICING';
  String issueNameTen = 'REPRODUCTIVE RIGHTS';
   */
  final List<String> _issuesLogo = [
    'assets/gunPolicyPogo.jpeg',
    'assets/climatePogo.jpg',
    'assets/educationPogo.jpeg',
    'assets/marijuana.png',
    'assets/healthcarePogo.jpg',
    'assets/housingPogo.jpg',
    'assets/economyPogo.jpg',
    'assets/immigrationPogo.jpg',
    'assets/policingPogo.jpg',
    'assets/reproductiveHealthPogo.jpg'
  ];
  final List<String> _issuesText = [
    'GUN POLICY',
    'CLIMATE CHANGE',
    'EDUCATION',
    'DRUG POLICY',
    'HEALTHCARE',
    'HOUSING',
    'ECONOMY',
    'IMMIGRATION',
    'POLICING',
    'REPRODUCTIVE RIGHTS'
  ];
  final List<String> _leftAlignText = [
    'Gun Control',
    'Acceptance',
    'Public',
    'Legalization',
    'Government Funded',
    'Affordable Housing',
    'Market Regulation',
    'Inclusive',
    'Divestment & Reallocation',
    'Abortion & Contraceptive Rights'
  ];
  final List<String> _rightAlignText = [
    'Gun Rights',
    'Doubt',
    'School Choice',
    'Criminalization',
    'Private',
    'Market Rate Housing',
    'Market Deregulation',
    'Exclusive',
    'Investment',
    'Abortion & Contraceptive Restrictions'
  ];
  final List<String> _issuesGeneralDefinitions = [
    'Gun policy refers to the laws and protections in place around firearms. Concerning the possession, transfer, or sale of firearms or the expansion of background checks for firearm purchases.',
    'Climate policy refers to rules to regulate innovation that affects the environment and the greater human race.',
    'Education policy refers to the plan and underlying principles for educating students. The goals of educational policy have evolved in the United States as society and culture have changed, and are continually being debated and revised.',
    'Drug policy refers to rules around the consumption, selling/and or purchasing of drugs or alcohol.',
    'Healthcare policy refers to the concerns people have when it comes to “health freedom” / the freedom to choose. Some people believe that health and medical systems are heavily influenced by big government or pharmaceutical money therefore they want the space to self-determine and choose for oneself one’s course of treatment and approach to health overall.',
    'Housing policy refers to the actions of the government, including legislation and program delivery, which have a direct or indirect impact on housing supply and availability, housing standards and urban planning.',
    'Economic Policy refers to the systems for managing taxation, government budgets, the money supply and interest rates as well as the labor market, national ownership, and many other areas of government interventions into the economy.',
    'Immigration policy refers to laws that control, protect, and manage the influx of people seeking to establish residence in the USA. It is rules regarding rights of access to the territory (entry and residence), permission to participate in the labor market (work permits), the rights of asylum seekers and refugees, the rights of immigrants to bring family members (family reunification), and rules for the acquisition of citizenship by immigrants and their family members (naturalization).',
    'Policing policies refer to the foundation for all operations in law enforcement. Including training, budget management, consequences for excessive use of force, etc.',
    'Reproductive Health policy refers to decisions and laws made around the reproductive system, its functions, and its processes.  It’s a state of complete physical, mental, and social well-being and not merely the absence of disease or infirmity.',
  ];
  final List<String> _issuesLeftDefinitions = [
    'People in favor of gun control desire laws to be put in place such as background checks, wait times before buying a gun, banning automatic weapons, and disallowing concealed weapons',
    'People in favor of climate policy are generally conservative in this area, preferring to ban economic activity that may create jobs but harm the environment.',
    'People in favor of public education believe every child in America, regardless of family income or place of residence, deserves access to a quality education. Including: expanded, free, public education including free college; student-loan forgiveness, teacher-pay raises, and universal pre-kindergarten.',
    'People who favor legalization believe that drug policy should be less strict including decreasing the penalties or punishments associated with the drug. Many people believe in the decriminalization of marijuana.',
    'People in favor of government-funded healthcare believe that access to healthcare is a fundamental right for all people. They support “Universal Healthcare”, “The Affordable Care Act”, and the expansion of Medicare and Medicaid.',
    'People in favor of Affordable housing believe that the government should support the creation of affordable housing and how it affects urban planning.',
    'People in favor of market regulation desire for the economy to be run by a cooperative collective agency, which can mean the state but also a network of communes.',
    'People in favor of inclusive immigration believe there should be pathways to citizenship for undocumented immigrants. Delay in deportations or prosecutions of undocumented immigrants who are young adults and have no criminal record.',
    'People in favor of Divestment and Reallocation advocate for investments made in supportive services and divestment from policing institutions. They believe that money is invested into minority communities to criminalize them instead of supporting them systematically.',
    'People in favor of “Pro-choice” generally believe in un-penalized access to abortion and both adult and embryonic stem cell research. They believe in “my body, my choice”.',
  ];
  final List<String> _issuesRightDefinitions = [
    'People in favor of gun rights are strongly opposed to gun laws. Many are strong advocates of the second amendment [the right to bear arms], including “freedom to carry” for self-protection and relying on the state at little as possible.',
    'People who doubt climate policy don’t believe the climate is a threat to our environment. They are more permissive when weighing the economic impact of environmental regulation. People who doubt climate change believe the free market will find its own solution to environmental issues.',
    'People in favor of school choice believe academic performance, free speech, and federal and state separation are essential to a good education. They believe “keeping Washington out of education” to ensure parents are in control of what their kids are learning in their districts.',
    'People who favor the criminalization of drugs believe that drug policy should be stricter including increasing the penalties or punishments associated with the drug.',
    'People in favor of private healthcare believe there should be competition with Medicare from private insurance companies. They oppose “Universal Healthcare”, “The Affordable Care Act”, and Medicare expansion.',
    'People in favor of Market rate housing believe that people should live where they can afford to and the government shouldn’t give tax breaks to support affordable housing.',
    'People in favor of market deregulation desire for the economy to be left to the devices of competing individuals and organizations.',
    'No “amnesty” for undocumented immigrants; stronger border patrol, etc. There’s a strong belief that illegal immigration is lowering the wages for citizens and documented immigrants.',
    'People in favor of Investment advocate for more funding for training, weaponry, and local policing infrastructure.',
    'People in favor of abortion and contraceptive criminalization believe that people shouldn’t get abortions or use contraceptives no matter what. They believe that a baby is alive at the moment of conception. Abortions/abortion relation surgeries and contraceptives should be criminalized.',
  ];

  IssuesDefinitions();

  List<String> get issuesRightDefinitions => _issuesRightDefinitions;

  List<String> get issuesLeftDefinitions => _issuesLeftDefinitions;

  List<String> get issuesGeneralDefinitions => _issuesGeneralDefinitions;

  List<String> get rightAlignText => _rightAlignText;

  List<String> get leftAlignText => _leftAlignText;

  List<String> get issuesText => _issuesText;

  List<String> get issuesLogo => _issuesLogo;
}