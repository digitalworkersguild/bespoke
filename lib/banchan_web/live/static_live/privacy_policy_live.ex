defmodule BanchanWeb.StaticLive.PrivacyPolicy do
  @moduledoc """
  Banchan Privacy Policy
  """
  use BanchanWeb, :surface_view

  alias Surface.Components.Markdown

  alias BanchanWeb.Components.Layout

  @impl true
  def handle_params(_params, uri, socket) do
    socket = Context.put(socket, uri: uri, flash: socket.assigns.flash)
    {:noreply, socket |> assign(uri: uri)}
  end

  @impl true
  def render(assigns) do
    ~F"""
    <Layout>
      <#Markdown class="prose">
        # Privacy Policy

        Last updated: August 3, 2022

        This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.

        We use Your Personal Data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.

        # Interpretation and Definitions

        ## Interpretation

        Capitalized words have meanings defined below. These definitions shall have the same meaning regardless of whether they appear in singular or in plural.

        ## Definitions

        For the purposes of this Privacy Policy:

        **Account** means a unique account created for You to access our Service or parts of our Service.

        **Business** , for the purpose of the CCPA (California Consumer Privacy Act), refers to the Company as the legal entity that collects Consumers' personal information and determines the purposes and means of the processing of Consumers' personal information, or on behalf of which such information is collected and that alone, or jointly with others, determines the purposes and means of the processing of consumers' personal information, that does business in the State of California.

        **Company** (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Digital Workers Guild LLC, 340 S Lemon Ave #8687, Walnut, CA 91789.

        **Consumer** , for the purpose of the CCPA (California Consumer Privacy Act), means a natural person who is a California resident. A resident, as defined in the law, includes (1) every individual who is in the USA for other than a temporary or transitory purpose, and (2) every individual who is domiciled in the USA who is outside the USA for a temporary or transitory purpose.

        **Cookies** are small files that are placed on Your computer, mobile device or any other device by a website, containing the details of Your browsing history on that website among its many uses.

        **Data Controller** , for the purposes of the GDPR (General Data Protection Regulation), refers to the Company as the legal person which alone or jointly with others determines the purposes and means of the processing of Personal Data.

        **Device** means any device that can access the Service such as a computer, a cellphone or a digital tablet.

        **Do Not Track** (DNT) is a concept that has been promoted by U.S. regulatory authorities, in particular the U.S. Federal Trade Commission (FTC), for the Internet industry to develop and implement a mechanism for allowing internet users to control the tracking of their online activities across websites.

        **Personal Data** is any information that relates to an identified or identifiable individual.

        For the purposes of GDPR, Personal Data means any information relating to You such as a name, an identification number, location data, online identifier or to one or more factors specific to the physical, physiological, genetic, mental, economic, cultural or social identity.

        For the purposes of the CCPA, Personal Data means any information that identifies, relates to, describes or is capable of being associated with, or could reasonably be linked, directly or indirectly, with You.

        **Sale** , for the purpose of the CCPA (California Consumer Privacy Act), means selling, renting, releasing, disclosing, disseminating, making available, transferring, or otherwise communicating orally, in writing, or by electronic or other means, a Consumer's personal information to another business or a third party for monetary or other valuable consideration.

        **Service** refers to the Website.

        **Service Provider** means any natural or legal person who processes data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used. For the purpose of the GDPR, Service Providers are considered Data Processors.

        **Third-Party Social Media Service** refers to any website or any social network website through which a User can log in or create an account to use the Service.

        **Usage Data** refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).

        **Website** refers to Banchan Art, accessible from [https://banchan.art](https://banchan.art).

        **You** means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.

        Under GDPR (General Data Protection Regulation), You can be referred to as the Data Subject or as the User as you are the individual using the Service.

        # Collecting and Using Your Personal Data

        ## Types of Data Collected

        ### Personal Data

        While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:

        Email address

        First name and last name

        Phone number

        Address, city, state/province, ZIP/postal code

        Usage Data

        ### Usage Data

        Usage Data is collected automatically when using the Service.

        Usage Data may include information such as Your Device's Internet Protocol address (e.g., IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.

        When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.

        We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.

        ### Information from Third-Party Social Media Services

        The Company allows You to create an account and log in to use the Service through the following Third-Party Social Media Services:

        - Discord
        - Google
        - Twitter

        If You decide to register through or otherwise grant us access to a Third-Party Social Media Service, We may collect Personal Data that is already associated with Your Third-Party Social Media Service's account, such as Your name, Your email address, or Your profile image associated with that account.

        You may also have the option of sharing additional information with the Company through Your Third-Party Social Media Service's account. If You choose to provide such information and Personal Data, during registration or otherwise, You are giving the Company permission to use, share, and store it in a manner consistent with this Privacy Policy.

        ### Tracking Technologies and Cookies

        We use Cookies and similar tracking technologies to track the activity on Our Service and store certain information. Tracking technologies used are beacons, tags, and scripts to collect and track information and to improve and analyze Our Service. The technologies We use may include:

        - **Cookies or Browser Cookies.** A Cookie is a small file placed on Your Device. You can instruct Your browser to refuse all Cookies or to indicate when a Cookie is being sent. However, if You do not accept Cookies, You may not be able to use some parts of our Service. Unless you have adjusted Your browser setting so that it will refuse Cookies, our Service may use Cookies.
        - **Web Beacons.** Certain sections of our Service and our emails may contain small electronic files known as web beacons (also referred to as clear gifs, pixel tags, and single-pixel gifs) that permit the Company, for example, to count users who have visited those pages or opened an email and for other related website statistics (for example, recording the popularity of a certain section and verifying system and server integrity).

        Cookies can be "Persistent" or "Session" Cookies. Persistent Cookies remain on Your Device when You go offline, while Session Cookies are deleted as soon as You close Your web browser.

        We use both Session and Persistent Cookies for the purposes set out below:

        **Necessary / Essential Cookies**

        Type: Session Cookies

        Administered by: Us

        Purpose: These Cookies are essential to provide You with services available through the Website and to enable You to use some of its features. They help to authenticate users and prevent fraudulent use of user accounts. Without these Cookies, the services that You have asked for cannot be provided, and We only use these Cookies to provide You with those services.

        **Cookies Policy / Notice Acceptance Cookies**

        Type: Persistent Cookies

        Administered by: Us

        Purpose: These Cookies identify if users have accepted the use of Cookies on the Website.

        **Functionality Cookies**

        Type: Persistent Cookies

        Administered by: Us

        Purpose: These Cookies allow us to remember choices You make when You use the Website, such as remembering your login details or language preference. The purpose of these Cookies is to provide You with a more personal experience and to avoid You having to re-enter your preferences every time You use the Website.

        **Tracking and Performance Cookies**

        Type: Persistent Cookies

        Administered by: Third-Parties

        Purpose: These Cookies are used to track information about traffic to the Website and how users use the Website. The information gathered via these Cookies may directly or indirectly identify you as an individual visitor. This is because the information collected is typically linked to a pseudonymous identifier associated with the device you use to access the Website. We may also use these Cookies to test new pages, features or new functionality of the Website to see how our users react to them.

        For more information about the Cookies we use and your choices regarding Cookies, please visit our Cookies Policy.

        ## Use of Your Personal Data

        The Company may use Personal Data for the following purposes:

        - **To provide and maintain Our Service** , including to monitor the usage of Our Service.
        - **To manage Your Account:** to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.
        - **For the performance of a contract:** the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.
        - **To contact You:** To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application's push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.
        - **To provide You** with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.
        - **To manage Your requests:** To attend and manage Your requests to Us.
        - **To deliver targeted advertising to You** : We may use Your information to develop and display content and advertising (and work with third-party vendors who do so) tailored to Your interests and/or location and to measure its effectiveness.
        - **For business transfers:** We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.
        - **For other purposes** : We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.

        We may share Your personal information in the following situations:

        - **With Service Providers:** We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to advertise on third-party websites to You after You visited our Service, for payment processing, to contact You.
        - **For business transfers:** We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.
        - **With Affiliates:** We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies, if any, that We control or that are under common control with Us.
        - **With business partners:** We may share Your information with Our business partners to offer You certain products, services or promotions.
        - **With other users:** when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside. If You interact with other users or register through a Third-Party Social Media Service, Your contacts on the Third-Party Social Media Service may see Your name, profile, pictures and description of Your activity. Similarly, other users will be able to view descriptions of Your activity, communicate with You and view Your profile.
        - **With Your consent** : We may disclose Your personal information for any other purpose with Your consent.

        ## Retention of Your Personal Data

        The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.

        The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.

        ## Transfer of Your Personal Data

        Your information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to—and maintained on—computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.

        Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.

        The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.

        ## Disclosure of Your Personal Data

        ### Business Transactions

        If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.

        ### Law enforcement

        Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g., a court or a government agency).

        ### Other legal requirements

        The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:

        - Comply with a legal obligation
        - Protect and defend the rights or property of the Company
        - Prevent or investigate possible wrongdoing in connection with the Service
        - Protect the personal safety of Users of the Service or the public
        - Protect against legal liability

        ## Security of Your Personal Data

        The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.

        # Detailed Information on the Processing of Your Personal Data

        The Service Providers We use may have access to Your Personal Data. These third-party vendors collect, store, use, process and transfer information about Your activity on Our Service in accordance with their Privacy Policies.

        ## Analytics

        We may use third-party Service providers to monitor and analyze the use of our Service.

        **Plausible Analytics**

        Plausible Analytics is a web analytics service offered as an alternative to Google Analytics that tracks and reports website traffic. Plausible Analytics uses the data collected to track and monitor the use of our Service.

        For more information on the privacy practices of Plausible Analytics, please visit the Plausible Analytics Privacy web page: [https://plausible.io/privacy](https://plausible.io/privacy)

        ## Email Marketing

        We may use Your Personal Data to contact You with newsletters, marketing or promotional materials and other information that may be of interest to You. You may opt-out of receiving any, or all, of these communications from Us by following the unsubscribe link or instructions provided in any email We send or by contacting Us.

        We may use Email Marketing Service Providers to manage and send emails to You.

        **SendGrid**

        SendGrid is an email marketing sending service provided by Twilio Inc.

        For more information on the privacy practices of SendGrid, please visit their Privacy policy: [https://www.twilio.com/legal/privacy](https://www.twilio.com/legal/privacy)

        ## Payments

        We may provide paid products and/or services within the Service. In that case, we may use third-party services for payment processing (e.g., payment processors).

        We will not store or collect Your payment card details or Your payout account details. That information is provided directly to Our third-party payment processors whose use of Your personal information is governed by their Privacy Policy. These payment processors adhere to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, Mastercard, American Express and Discover. PCI-DSS requirements help ensure the secure handling of payment information.

        **Stripe**

        Their Privacy Policy can be viewed at [https://stripe.com/us/privacy](https://stripe.com/us/privacy)

        ## Behavioral Remarketing

        The Company uses remarketing services to advertise to You after You accessed or visited our Service. We and Our third-party vendors use Cookies and non-Cookie technologies to help Us recognize Your Device and understand how You use our Service so that We can improve our Service to reflect Your interests and serve You advertisements that are likely to be of more interest to You.

        These third-party vendors collect, store, use, process and transfer information about Your activity on Our Service in accordance with their Privacy Policies and to enable Us to:

        - Measure and analyze traffic and browsing activity on Our Service
        - Show advertisements for our products and/or services to You on third-party websites or apps
        - Measure and analyze the performance of Our advertising campaigns

        Some of these third-party vendors may use non-Cookie technologies that may not be impacted by browser settings that block Cookies. Your browser may not permit You to block such technologies. You can use the following third-party tools to decline the collection and use of information for the purpose of serving You interest-based advertising:

        - The NAI's opt-out platform: [http://www.networkadvertising.org/choices/](http://www.networkadvertising.org/choices/)
        - The EDAA's opt-out platform [http://www.youronlinechoices.com/](http://www.youronlinechoices.com/)
        - The DAA's opt-out platform: [http://optout.aboutads.info/?c=2&amp;lang=EN](http://optout.aboutads.info/?c=2&lang=EN)

        You may opt-out of all personalized advertising by enabling privacy features on Your mobile device such as Limit Ad Tracking (iOS) and Opt Out of Ads Personalization (Android). See Your mobile device help system for more information.

        We may share information, such as hashed email addresses (if available) or other online identifiers collected on Our Service with these third-party vendors. This allows Our third-party vendors to recognize and deliver You ads across devices and browsers. To read more about the technologies used by these third-party vendors and their cross-device capabilities please refer to the Privacy Policy of each vendor listed below.

        The third-party vendors We use are:

        **Google Ads (AdWords)**

        Google Ads (AdWords) remarketing service is provided by Google Inc.

        You can opt-out of Google Analytics for Display Advertising and customise the Google Display Network ads by visiting the Google Ads Settings page: [http://www.google.com/settings/ads](http://www.google.com/settings/ads)

        Google also recommends installing the Google Analytics Opt-out Browser Add-on - [https://tools.google.com/dlpage/gaoptout](https://tools.google.com/dlpage/gaoptout) - for your web browser. Google Analytics Opt-out Browser Add-on provides visitors with the ability to prevent their data from being collected and used by Google Analytics.

        For more information on the privacy practices of Google, please visit the Google Privacy &amp; Terms web page: [https://policies.google.com/privacy](https://policies.google.com/privacy)

        **Twitter**

        Twitter remarketing service is provided by Twitter Inc.

        You can opt-out from Twitter's interest-based ads by following their instructions: [https://support.twitter.com/articles/20170405](https://support.twitter.com/articles/20170405)

        You can learn more about the privacy practices and policies of Twitter by visiting their Privacy Policy page: [https://twitter.com/privacy](https://twitter.com/privacy)

        **Facebook**

        Facebook remarketing service is provided by Facebook Inc.

        You can learn more about interest-based advertising from Facebook by visiting this page: [https://www.facebook.com/help/516147308587266](https://www.facebook.com/help/516147308587266)

        To opt-out from Facebook's interest-based ads, follow these instructions from Facebook: [https://www.facebook.com/help/568137493302217](https://www.facebook.com/help/568137493302217)

        Facebook adheres to the Self-Regulatory Principles for Online Behavioural Advertising established by the Digital Advertising Alliance. You can also opt-out from Facebook and other participating companies through the Digital Advertising Alliance in the USA [http://www.aboutads.info/choices/](http://www.aboutads.info/choices/), the Digital Advertising Alliance of Canada in Canada [http://youradchoices.ca/](http://youradchoices.ca/) or the European Interactive Digital Advertising Alliance in Europe [http://www.youronlinechoices.eu/](http://www.youronlinechoices.eu/), or opt-out using your mobile device settings.

        For more information on the privacy practices of Facebook, please visit Facebook's Data Policy: [https://www.facebook.com/privacy/explanation](https://www.facebook.com/privacy/explanation)

        **Pinterest**

        Pinterest remarketing service is provided by Pinterest Inc.

        You can opt-out from Pinterest's interest-based ads by enabling the "Do Not Track" functionality of your web browser or by following Pinterest instructions: [http://help.pinterest.com/en/articles/personalization-and-data](http://help.pinterest.com/en/articles/personalization-and-data)

        You can learn more about the privacy practices and policies of Pinterest by visiting their Privacy Policy page: [https://about.pinterest.com/en/privacy-policy](https://about.pinterest.com/en/privacy-policy)

        # GDPR Privacy

        ## Legal Basis for Processing Personal Data under GDPR

        We may process Personal Data under the following conditions:

        - **Consent:** You have given Your consent for processing Personal Data for one or more specific purposes.
        - **Performance of a contract:** Provision of Personal Data is necessary for the performance of an agreement with You and/or for any pre-contractual obligations thereof.
        - **Legal obligations:** Processing Personal Data is necessary for compliance with a legal obligation to which the Company is subject.
        - **Vital interests:** Processing Personal Data is necessary in order to protect Your vital interests or of another natural person.
        - **Public interests:** Processing Personal Data is related to a task that is carried out in the public interest or in the exercise of official authority vested in the Company.
        - **Legitimate interests:** Processing Personal Data is necessary for the purposes of the legitimate interests pursued by the Company.

        In any case, the Company will gladly help to clarify the specific legal basis that applies to the processing, and in particular whether the provision of Personal Data is a statutory or contractual requirement, or a requirement necessary to enter into a contract.

        ## Your Rights under the GDPR

        The Company undertakes to respect the confidentiality of Your Personal Data and to guarantee You can exercise Your rights.

        You have the right under this Privacy Policy, and by law if You are within the EU, to:

        - **Request access to Your Personal Data.** The right to access, update or delete the information We have on You. Whenever made possible, you can access, update or request deletion of Your Personal Data directly within Your account settings section. If you are unable to perform these actions yourself, please contact Us to assist You. This also enables You to receive a copy of the Personal Data We hold about You.
        - **Request correction of the Personal Data that We hold about You.** You have the right to have any incomplete or inaccurate information We hold about You corrected.
        - **Object to processing of Your Personal Data.** This right exists where We are relying on a legitimate interest as the legal basis for Our processing and there is something about Your particular situation, which makes You want to object to our processing of Your Personal Data on this ground. You also have the right to object where We are processing Your Personal Data for direct marketing purposes.
        - **Request erasure of Your Personal Data.** You have the right to ask Us to delete or remove Personal Data when there is no good reason for Us to continue processing it.
        - **Request the transfer of Your Personal Data.** We will provide to You, or to a third party You have chosen, Your Personal Data in a structured, commonly used, machine-readable format. Please note that this right only applies to automated information which You initially provided consent for Us to use or where We used the information to perform a contract with You.
        - **Withdraw Your consent.** You have the right to withdraw Your consent on using your Personal Data. If You withdraw Your consent, We may not be able to provide You with access to certain specific functionalities of the Service.

        ## Exercising of Your GDPR Data Protection Rights

        You may exercise Your rights of access, rectification, cancellation and opposition by contacting Us. Please note that we may ask You to verify Your identity before responding to such requests. If You make a request, We will try our best to respond to You as soon as possible.

        You have the right to complain to a Data Protection Authority about Our collection and use of Your Personal Data. For more information, if You are in the European Economic Area (EEA), please contact Your local data protection authority in the EEA.

        # CCPA Privacy

        This privacy notice section for California residents supplements the information contained in Our Privacy Policy and it applies solely to all visitors, users, and others who reside in the State of California.

        ## Categories of Personal Information Collected

        We collect information that identifies, relates to, describes, references, is capable of being associated with, or could reasonably be linked, directly or indirectly, with a particular Consumer or Device. The following is a list of categories of personal information which we may collect or may have been collected from California residents within the last 12 months.

        Please note that the categories and examples provided in the list below are those defined in the CCPA. This does not mean that all examples of that category of personal information were in fact collected by Us, but reflects our good faith belief to the best of our knowledge that some of that information from the applicable category may be and may have been collected. For example, certain categories of personal information would only be collected if You provided such personal information directly to Us.

        **Category A: Identifiers.**

        Examples: A real name, alias, postal address, unique personal identifier, online identifier, Internet Protocol address, email address, account name, driver's license number, passport number, or other similar identifiers.

        Collected: Yes.

        **Category B: Personal information categories listed in the California Customer Records statute Cal. Civ. Code § 1798.80(e).**

        Examples: A name, signature, Social Security number, physical characteristics or description, address, telephone number, passport number, driver's license or state identification card number, insurance policy number, education, employment, employment history, bank account number, credit card number, debit card number, or any other financial information, medical information, or health insurance information. Some personal information included in this category may overlap with other categories.

        Collected: Yes.

        **Category C: Protected classification characteristics under California or federal law.**

        Examples: Age (40 years or older), race, color, ancestry, national origin, citizenship, religion or creed, marital status, medical condition, physical or mental disability, sex (including gender, gender identity, gender expression, pregnancy or childbirth and related medical conditions), sexual orientation, veteran or military status, genetic information (including familial genetic information).

        Collected: Yes.

        **Category D: Commercial information.**

        Examples: Records and history of products or services purchased or considered.

        Collected: Yes.

        **Category E: Biometric information.**

        Examples: Genetic, physiological, behavioral, and biological characteristics, or activity patterns used to extract a template or other identifier or identifying information, such as, fingerprints, faceprints, and voiceprints, iris or retina scans, keystroke, gait, or other physical patterns, and sleep, health, or exercise data.

        Collected: No.

        **Category F: Internet or other similar network activity.**

        Examples: Interaction with our Service or advertisement.

        Collected: Yes.

        **Category G: Geolocation data.**

        Examples: Approximate physical location.

        Collected: No.

        **Category H: Sensory data.**

        Examples: Audio, electronic, visual, thermal, olfactory, or similar information.

        Collected: No.

        **Category I: Professional or employment-related information.**

        Examples: Current or past job history or performance evaluations.

        Collected: No.

        **Category J: Non-public education information (per the Family Educational Rights and Privacy Act, 20 U.S.C. Section 1232g, 34 C.F.R. Part 99).**

        Examples: Education records directly related to a student maintained by an educational institution or party acting on its behalf, such as grades, transcripts, class lists, student schedules, student identification codes, student financial information, or student disciplinary records.

        Collected: No.

        **Category K: Inferences drawn from other personal information.**

        Examples: Profile reflecting a person's preferences, characteristics, psychological trends, predispositions, behavior, attitudes, intelligence, abilities, and aptitudes.

        Collected: No.

        Under CCPA, personal information does not include:

        - Publicly available information from government records
        - Deidentified or aggregated consumer information
        - Information excluded from the CCPA's scope, such as:

        - Health or medical information covered by the Health Insurance Portability and Accountability Act of 1996 (HIPAA) and the California Confidentiality of Medical Information Act (CMIA) or clinical trial data
        - Personal Information covered by certain sector-specific privacy laws, including the Fair Credit Reporting Act (FRCA), the Gramm-Leach-Bliley Act (GLBA) or California Financial Information Privacy Act (FIPA), and the Driver's Privacy Protection Act of 1994

        ## Sources of Personal Information

        We obtain the categories of personal information listed above from the following categories of sources:

        - **Directly from You**. For example, from the forms You complete on our Service, preferences You express or provide through our Service, or from Your purchases on our Service.
        - **Indirectly from You**. For example, from observing Your activity on our Service.
        - **Automatically from You**. For example, through Cookies We or our Service Providers set on Your Device as You navigate through our Service.
        - **From Service Providers**. For example, third-party vendors to monitor and analyze the use of our Service, third-party vendors to deliver targeted advertising to You, third-party vendors for payment processing, or other third-party vendors that We use to provide the Service to You.

        ## Use of Personal Information for Business Purposes or Commercial Purposes

        We may use or disclose personal information We collect for "business purposes" or "commercial purposes" (as defined under the CCPA), which may include the following examples:

        - To operate our Service and provide You with our Service.
        - To provide You with support and to respond to Your inquiries, including to investigate and address Your concerns and monitor and improve our Service.
        - To fulfill or meet the reason You provided the information. For example, if You share Your contact information to ask a question about our Service, We will use that personal information to respond to Your inquiry. If You provide Your personal information to purchase a product or service, We will use that information to process Your payment and facilitate delivery.
        - To respond to law enforcement requests and as required by applicable law, court order, or governmental regulations.
        - As described to You when collecting Your personal information or as otherwise set forth in the CCPA.
        - For internal administrative and auditing purposes.
        - To detect security incidents and protect against malicious, deceptive, fraudulent or illegal activity, including, when necessary, to prosecute those responsible for such activities.

        Please note that the examples provided above are illustrative and not intended to be exhaustive. For more details on how we use this information, please refer to the "Use of Your Personal Data" section.

        If We decide to collect additional categories of personal information or use the personal information We collected for materially different, unrelated, or incompatible purposes We will update this Privacy Policy.

        ## Disclosure of Personal Information for Business Purposes or Commercial Purposes

        We may use or disclose and may have used or disclosed in the last 12 months the following categories of personal information for business or commercial purposes:

        - Category A: Identifiers
        - Category B: Personal information categories listed in the California Customer Records statute Cal. Civ. Code § 1798.80(e)
        - Category D: Commercial information
        - Category F: Internet or other similar network activity

        Please note that the categories listed above are those defined in the CCPA. This does not mean that all examples of that category of personal information were in fact disclosed, but reflects our good faith belief to the best of our knowledge that some of that information from the applicable category may be and may have been disclosed.

        When We disclose personal information for a business purpose or a commercial purpose, We enter a contract that describes the purpose and requires the recipient to both keep that personal information confidential and not use it for any purpose except performing the contract.

        ## Sale of Personal Information

        As defined in the CCPA, "sell" and "sale" mean selling, renting, releasing, disclosing, disseminating, making available, transferring, or otherwise communicating orally, in writing, or by electronic or other means, a consumer's personal information by the business to a third party for valuable consideration.

        We do not sell personal information. In the preceding 12 months, We have not sold any personal information.

        ## Share of Personal Information

        We may share Your personal information identified in the above categories with the following categories of third parties:

        - Service Providers
        - Payment processors
        - Our affiliates
        - Our business partners
        - Third-party vendors to whom You or Your agents authorize Us to disclose Your personal information in connection with products or services We provide to You

        ## Your Rights under the CCPA

        The CCPA provides California residents with specific rights regarding their personal information. If You are a resident of California, You have the following rights:

        - **The right to notice.** You have the right to be notified which categories of Personal Data are being collected and the purposes for which the Personal Data is being used.
        - **The right to request.** Under CCPA, You have the right to request that We disclose information to You about Our collection, use, sale, disclosure for business purposes and share of personal information. Once We receive and confirm Your request, We will disclose to You:

        - The categories of personal information We collected about You
        - The categories of sources for the personal information We collected about You
        - Our business or commercial purpose for collecting or selling that personal information
        - The categories of third parties with whom We share that personal information
        - The specific pieces of personal information We collected about You
        - If we sold Your personal information or disclosed Your personal information for a business purpose, We will disclose to You:

        - The categories of personal information categories sold
        - The categories of personal information categories disclosed

        - **The right to say no to the sale of Personal Data (opt-out).** You have the right to direct Us to not sell Your personal information. To submit an opt-out request please contact Us. Please note, however, that We do not currently sell any personal information.
        - **The right to delete Personal Data.** You have the right to request the deletion of Your Personal Data, subject to certain exceptions. Once We receive and confirm Your request, We will delete (and direct Our Service Providers to delete) Your personal information from our records, unless an exception applies. We may deny Your deletion request if retaining the information is necessary for Us or Our Service Providers to:

        - Complete the transaction for which We collected the personal information, provide a good or service that You requested, take actions reasonably anticipated within the context of our ongoing business relationship with You, or otherwise perform our contract with You.
        - Detect security incidents, protect against malicious, deceptive, fraudulent, or illegal activity, or prosecute those responsible for such activities.
        - Debug products to identify and repair errors that impair existing intended functionality.
        - Exercise free speech, ensure the right of another consumer to exercise their free speech rights, or exercise another right provided for by law.
        - Comply with the California Electronic Communications Privacy Act (Cal. Penal Code § 1546 et. seq.).
        - Engage in public or peer-reviewed scientific, historical, or statistical research in the public interest that adheres to all other applicable ethics and privacy laws, when the information's deletion may likely render impossible or seriously impair the research's achievement, if You previously provided informed consent.
        - Enable solely internal uses that are reasonably aligned with consumer expectations based on Your relationship with Us.
        - Comply with a legal obligation.
        - Make other internal and lawful uses of that information that are compatible with the context in which You provided it.

        - **The right not to be discriminated against.** You have the right not to be discriminated against for exercising any of Your consumer's rights, including by:

        - Denying goods or services to You.
        - Charging different prices or rates for goods or services, including the use of discounts or other benefits or imposing penalties.
        - Providing a different level or quality of goods or services to You.
        - Suggesting that You will receive a different price or rate for goods or services or a different level or quality of goods or services.

        ## Exercising Your CCPA Data Protection Rights

        In order to exercise any of Your rights under the CCPA, and if You are a California resident, You can contact Us:

        - By email: support@banchan.art

        Only You, or a person registered with the California Secretary of State that You authorize to act on Your behalf, may make a verifiable request related to Your personal information.

        Your request to Us must:

        - Provide sufficient information that allows Us to reasonably verify You are the person about whom We collected personal information or an authorized representative.
        - Describe Your request with sufficient detail that allows Us to properly understand, evaluate, and respond to it.

        We cannot respond to Your request or provide You with the required information if We cannot:

        - Verify Your identity or authority to make the request
        - And confirm that the personal information relates to You.

        We will disclose and deliver the required information free of charge within 45 days of receiving Your verifiable request. The time period to provide the required information may be extended once by an additional 45 days when reasonably necessary and with prior notice.

        Any disclosures We provide will only cover the 12-month period preceding the verifiable request's receipt.

        For data portability requests, We will select a format to provide Your personal information that is readily usable and should allow You to transmit the information from one entity to another entity without hindrance.

        ## Do Not Sell My Personal Information

        You have the right to opt-out of the sale of Your personal information. Please note, however, that We do not sell any personal information in any case. If we were ever to start selling personal information, You could choose to opt out. If We were to receive and confirm a verifiable consumer request from You, we would stop selling Your personal information. To exercise Your right to opt-out, please contact Us.

        The Service Providers we partner with (for example, our analytics or advertising partners) may use technology on the Service that sells personal information as defined by the CCPA law. If you wish to opt out of the use of Your personal information for interest-based advertising purposes and these potential sales as defined under CCPA law, you may do so by following the instructions below.

        Please note that any opt out is specific to the browser You use. You may need to opt out on every browser that You use.

        ### Website

        You can opt out of receiving ads that are personalized as served by our Service Providers by following our instructions presented on the Service:

        - The NAI's opt-out platform: [http://www.networkadvertising.org/choices/](http://www.networkadvertising.org/choices/)
        - The EDAA's opt-out platform [http://www.youronlinechoices.com/](http://www.youronlinechoices.com/)
        - The DAA's opt-out platform: [http://optout.aboutads.info/?c=2&amp;lang=EN](http://optout.aboutads.info/?c=2&lang=EN)

        The opt out will place a Cookie on Your computer that is unique to the browser You use to opt out. If you change browsers or delete the Cookies saved by your browser, You will need to opt out again.

        ### Mobile Devices

        Your mobile device may give You the ability to opt out of the use of information about the apps You use in order to serve You ads that are targeted to Your interests:

        - "Opt out of Interest-Based Ads" or "Opt out of Ads Personalization" on Android devices
        - "Limit Ad Tracking" on iOS devices

        You can also stop the collection of location information from Your mobile device by changing the preferences on Your mobile device.

        "

        # Do Not Track" Policy as Required by California Online Privacy Protection Act (CalOPPA)

        Our Service does not respond to Do Not Track signals.

        However, some third-party websites do keep track of Your browsing activities. If You are visiting such websites, You can set Your preferences in Your web browser to inform websites that You do not want to be tracked. You can enable or disable DNT by visiting the preferences or settings page of Your web browser.

        # Children's Privacy

        Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.

        If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.

        # Your California Privacy Rights (California's Shine the Light law)

        Under California Civil Code Section 1798 (California's Shine the Light law), California residents with an established business relationship with us can request information once a year about sharing their Personal Data with third parties for the third parties' direct marketing purposes.

        If you'd like to request more information under the California Shine the Light law, and if You are a California resident, You can contact Us using the contact information provided below.

        # California Privacy Rights for Minor Users (California Business and Professions Code Section 22581)

        California Business and Professions Code Section 22581 allows California residents under the age of 18 who are registered users of online sites, services or applications to request and obtain removal of content or information they have publicly posted.

        To request removal of such data, and if You are a California resident, You can contact Us using the contact information provided below, and include the email address associated with Your account.

        Be aware that Your request does not guarantee complete or comprehensive removal of content or information posted online and that the law may not permit or require removal in certain circumstances.

        # Links to Other Websites

        Our Service may contain links to other websites that are not operated by Us. If You click on a third-party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.

        We have no control over and assume no responsibility for the content, privacy policies or practices of any third-party sites or services.

        # Changes to this Privacy Policy

        We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.

        We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.

        You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.

        # Contact Us

        If you have any questions about this Privacy Policy, You can contact us:

        - By email: [support@banchan.art](mailto:support@banchan.art)

      </#Markdown>
    </Layout>
    """
  end
end
