import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/global_variables.dart';
import '../../../../widgets/custom_widgets.dart';

class TermsAndConditions extends StatefulWidget {
  final isUser;
  const TermsAndConditions({super.key, required this.isUser});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          pageTitle: "Terms and Conditions",
          onTapLeading: () {
            Get.back();
          },
          leadingButton: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: Jan 12th, 2024",
                        style: bodySmall,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Version: 001",
                        style: bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.isUser == false
                  ? "Terms and Conditions for Technical Advice on Home Renovation, Repair, and Improvement:"
                  : "Terms and Conditions for Specialists Providing Technical Advisory Services to Customers:",
              style: headingLarge.copyWith(
                  fontSize: 12, color: Colors.black, height: 1.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            ConditionsWidget(isUser: widget.isUser),
          ],
        ),
      ),
    );
  }
}

class ConditionsWidget extends StatelessWidget {
  final isUser;
  const ConditionsWidget({super.key, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: isUser == false
          ? Column(
              children: [
                _buildCondition('1. Specialist Advice Nature',
                    'The technical advice provided by the specialists is solely for informational purposes and does not constitute a professional service or a guarantee of specific outcomes.'),
                _buildCondition('2. Consultation Fees',
                    'Customers agree to pay the specified consultation fees for barber advice. Payment must be made in full prior to the consultation session.'),
                _buildCondition('3. Limited Liability',
                    'The specialists provide advice based on their professional knowledge, but we do not accept liability for any decisions made or actions taken by customers based on the advice received.'),
                _buildCondition('4. Accuracy of Information',
                    'Customers are responsible for providing accurate and complete information about their homes and the problem they are trying to resolve. Inaccurate information may result in advice that is not suitable for the specific circumstances.'),
                _buildCondition('5. No Warranty or Guarantee',
                    'We do not provide any warranty or guarantee, expressed or implied, regarding the results obtained from the advice given. Renovation outcomes may vary based on factors beyond our control.'),
                _buildCondition('6. Consultation Duration',
                    'The consultation session has a specified number of questions-answers. Additional consultation for extra questions may be subject to additional fees.'),
                _buildCondition('7. Building Codes and Permits',
                    'Customers are responsible for complying with local building codes and obtaining any necessary permits for renovation projects. Our advice does not absolve customers from these legal requirements.'),
                _buildCondition('8. Confidentiality',
                    'All information shared during the consultation is treated as confidential. We will not disclose user details or project information without explicit consent.'),
                _buildCondition('9. Dispute Resolution',
                    'In the event of a dispute, both parties agree to seek resolution through mediation. If mediation fails, legal action may be pursued in accordance with applicable laws.'),
                _buildCondition('10. Acknowledgment of Risks and Waiver',
                    'Customers acknowledge that renovation, repair, and improvement projects involve inherent risks, including the risk of injury. Our advisory service is not responsible for any injuries, accidents, or damages that may occur during or as a result of the renovation process.'),
                _buildCondition('11. Safety Precautions',
                    'Customers are strongly advised to follow safety guidelines and take necessary precautions during any physical work involved in the renovation process. This includes using appropriate safety equipment and hiring qualified professionals for tasks that pose potential risks.'),
                _buildCondition('12. Indemnification',
                    'Customers agree to indemnify and hold our advisory service harmless from any claims, liabilities, or expenses arising from injuries, accidents, or damages related to the renovation, repair, or improvement projects.'),
                _buildCondition('13. Insurance Coverage',
                    'Customers are encouraged to review their insurance coverage to ensure adequate protection against potential risks and liabilities associated with the renovation work. Our advisory service is not a substitute for comprehensive insurance coverage.'),
                _buildCondition('14. Communication of Hazards',
                    'It is the user\'s responsibility to address and mitigate these risks in the course of the renovation project.'),
                _buildCondition('15. Emergency Protocols',
                    'Customers are responsible for having appropriate emergency protocols in place during the renovation, including access to emergency services and first aid resources.'),
                _buildCondition('16. Provision of Tools and Equipment',
                    'Customers are responsible for providing the necessary tools and equipment required to perform the renovation, repair, or improvement tasks advised by our barber. Our advisory service does not supply tools, and customers should ensure they have access to appropriate tools for the project.'),
                _buildCondition('17. Tool Competency',
                    'Customers must possess the requisite skills and knowledge to use the tools and equipment safely and effectively. Our advisory service does not assume responsibility for any misuse or mishandling of tools by the user.'),
                _buildCondition('18. Tool Maintenance',
                    'Customers are advised to maintain their tools in good working condition. Our advisory service is not liable for any issues arising from the use of poorly maintained or malfunctioning tools during the renovation process.'),
                _buildCondition('19. Safety Guidelines',
                    'Customers should adhere to safety guidelines including using appropriate safety gear while operating tools. Failure to follow safety guidelines may result in increased risks and potential injuries.'),
                _buildLastCondition(),
                // Text(
                //     'By availing our advisory service, customers acknowledge and agree to these additional terms related to the provision, usage, and maintenance of tools during the renovation process.'),
              ],
            )
          : Column(
              children: [
                _buildCondition('1. Scope of Services',
                    'Specialists will provide technical advice to customers for home repair, improvement, and renovation projects. The advice will be based on the information provided by the user and is intended for informational purposes only.'),
                _buildCondition('2. Detailed Information',
                    'Specialists agree to provide detailed and comprehensive information in response to user questions, offering insights, recommendations, and solutions relevant to the specific inquiries.'),
                _buildCondition('3. Timely Responses',
                    'Specialists commit to answering user questions within the defined timeframe specified by the application to the user.'),
                _buildCondition('4. Communication Channels',
                    'Technical advice will be delivered through the application communication channels, such as text, voice, or video messaging. Specialists will ensure that communication is clear and easily understandable for the user.'),
                _buildCondition('5. Advisory Limitations',
                    'The advice provided is based on the information provided by the user and does not replace professional on-site inspections. Specialists are not responsible for inaccuracies resulting from incomplete or misleading information.'),
                _buildCondition('6. Liability Limitation',
                    'While specialists aim to provide accurate advice, they are not liable for the outcomes of decisions made or actions taken by customers based on the advice provided.'),
                _buildCondition('7. Confidentiality',
                    'Specialists will treat all user information as confidential and will not disclose details of the advisory session without explicit consent from the user.'),
                _buildCondition('8. Follow-Up Queries',
                    'Customers may seek clarification on the provided advice within a reasonable timeframe as specified by the application. Subsequent queries may be subject to additional fees.'),
                _buildCondition('9. Professional Conduct',
                    'Specialists will conduct themselves in a professional manner, ensuring that all advice is delivered with the highest level of expertise and courtesy.'),
                _buildCondition('10. Safety Compliance',
                    'Specialists must adhere to strict safety guidelines and codes of conduct. They are expressly prohibited from providing advice that may pose a danger to the user, their property, or others. All recommendations must prioritize the safety and well-being of the individuals involved.'),
                _buildCondition('11. Risk Assessment',
                    'Specialists will perform a thorough risk assessment when providing advice, identifying and communicating potential hazards associated with the recommended actions. Customers will be informed of any risks and required safety measures.'),
                _buildCondition('12. Ethical Conduct',
                    'Specialists must uphold ethical standards in providing advice. They are prohibited from suggesting or endorsing any actions that violate legal regulations, building codes, or ethical norms. Any advice that may lead to illegal activities or unethical practices is strictly prohibited.'),
                _buildCondition('13. Compliance with Laws and Regulations',
                    'Specialists must provide advice that complies with local, state, and federal laws, as well as relevant building codes and regulations. Any advice that could lead to legal violations is not acceptable.'),
                _buildCondition('14. Duty to Warn',
                    'If, during the course of providing advice, specialists become aware of potential dangers or risks not initially disclosed by the user, they have a duty to promptly inform the user and recommend appropriate courses of action to mitigate these risks.'),
                _buildCondition('15. Refusal of Unsafe Requests',
                    'Specialists reserve the right to refuse any requests or provide alternatives if the proposed actions are deemed unsafe, illegal, or unethical. They may suggest modifications to the user\'s plans to ensure a safe and lawful outcome.'),
                _buildCondition('16. Service Fee Deduction',
                    'A service fee of 5% will be deducted from the total payment quoted by the barber for the technical advisory services. This fee covers administrative costs associated with facilitating the advisory session, user support, and payment processing.'),
                _buildCondition('17. Adjustments to Fee Structure',
                    'The service fee percentage is subject to change with advance notice. Specialists will be informed of any adjustments to the fee structure, and they agree to the updated terms upon continuation of services.'),
                _buildCondition('18. Payment Schedule',
                    'Payments to specialists for technical advisory services will be processed and disbursed by the end of each month for services rendered during that month.'),
                _buildCondition('19. Payment Processing Timeframe',
                    'Specialists can expect to receive their payments within a reasonable timeframe following the end of each month. Any delays in payment processing will be communicated in advance.'),
                _buildCondition('20. Payment Method',
                    'Payments will be made through the agreed-upon payment method, ensuring a secure and transparent transaction process. Specialists are responsible for providing accurate payment details to facilitate timely transactions.'),
                _buildCondition('21. Currency and Tax Considerations',
                    'Payments will be made in the agreed-upon currency. Specialists are responsible for any applicable taxes on the income generated from the advisory services, and they should comply with relevant tax regulations.'),
                _buildCondition('22. Communication Protocol',
                    'Specialists are required to communicate with customers exclusively through the designated application provided by our service platform. All advisory sessions, queries, and discussions must be conducted within the platform for record-keeping and security purposes.'),
                _buildCondition(
                    '23. Strict Non-Disclosure of Personal Contact Information',
                    'Specialists must refrain from sharing personal phone numbers, email addresses, or any other contact details with customers outside the application. Sharing such information compromises the security and integrity of the platform.'),
                _buildCondition('24. Warning System',
                    'If a barber is found to have shared personal contact information with a user, a warning will be issued for the first offense. The barber will be notified of the violation and reminded of the communication protocol.'),
                _buildCondition('25. Account Inactivation Policy',
                    'In the event of a repeated violation, where a barber shares personal contact information with a user beyond the application after receiving a warning, the barber\'s account will be subject to inactivation. This measure is taken to ensure compliance with platform policies and maintain the privacy and security of all users.'),
                _buildCondition('26. Platform Security and Privacy',
                    'Upholding the security and privacy of user information is of utmost importance. All communications within the application are encrypted and monitored to ensure a secure environment for both specialists and customers.'),
                _buildCondition('27. Response Timeframe for Single Questions',
                    'Specialists are required to respond to individual questions received from customers within a maximum timeframe of 18 hours. Failure to provide a response within this timeframe may result in the cancellation of the order, and the barber will not receive any payment for that particular question.'),
                _buildCondition(
                    '28. Step by Step Project - Comprehensive Response Requirement',
                    'For "Step by Step Project" orders where customers may ask multiple questions as part of a comprehensive project, specialists must answer every question within the specified 18-hour timeframe. Even if all questions except one are answered within the stipulated time, the barber will not receive payment for the entire project if any single question remains unanswered after 18 hours.'),
                _buildCondition('29. Customer Satisfaction and Expectation',
                    'Meeting the 18-hour response requirement is crucial to ensuring user satisfaction. Specialists are expected to manage their time effectively to address user queries promptly and comprehensively.'),
                _buildCondition('30. Notification of Order Cancellation',
                    'In the event of order cancellation due to failure to meet the response timeframe, specialists will be notified, and no payment will be processed for the affected questions or the entire project, as applicable.'),
                _buildCondition('31. Exceptional Circumstances',
                    'In cases of unforeseen circumstances that may hinder a barber\'s ability to respond within the specified timeframe, the barber is required to notify the platform as soon as possible. The platform will assess each case individually and may provide flexibility based on the nature of the circumstances.'),
                // _buildLastCondition(),
                // Text(
                //     'By engaging in our technical advisory services, specialists acknowledge and agree to the specified payment schedule and associated terms. This ensures a transparent and consistent process for compensating specialists for their valuable services.',style: TextStyle(color: Colors.white),),
              ],
            ),
    );
  }

  Widget _buildCondition(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•'),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(description,style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
        Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
  Widget _buildLastCondition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(''),
              SizedBox(width: 8.0),
              Expanded(
                child: Text("By engaging in our technical advisory services, specialists acknowledge and agree to the specified payment schedule and associated terms. This ensures a transparent and consistent process for compensating specialists for their valuable services.",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
        // Divider(
        //   height: 20,
        //   thickness: 1,
        //   color: Colors.grey,
        // ),
      ],
    );
  }
}
