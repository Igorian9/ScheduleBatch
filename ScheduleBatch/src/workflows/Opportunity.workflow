<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Email_to_CEO1</fullName>
        <description>Send Email to CEO about opportunity</description>
        <protected>false</protected>
        <recipients>
            <recipient>bahlik@softheme.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X1M_Opportunity_Alert</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_CEO_about_opportunity</fullName>
        <description>Send Email to CEO about opportunity</description>
        <protected>false</protected>
        <recipients>
            <recipient>CEO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bahlik@softheme.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X1M_Opportunity_Alert</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Sales_manager</fullName>
        <ccEmails>igor_igorovuich@i.ua</ccEmails>
        <description>Send Email to Sales manager</description>
        <protected>false</protected>
        <recipients>
            <recipient>bahlik@softheme.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Dad</template>
    </alerts>
    <fieldUpdates>
        <fullName>Close_Opportunity</fullName>
        <field>StageName</field>
        <literalValue>Closed Lost</literalValue>
        <name>Close Opportunity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_name_Field_Update</fullName>
        <field>Name</field>
        <formula>Account.Name + &apos;-&apos; + Name</formula>
        <name>Opportunity name Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Name</fullName>
        <field>Name</field>
        <formula>Account.Name &amp; &apos;: &apos; &amp; Name</formula>
        <name>Set Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_deal_level</fullName>
        <field>Deal_level__c</field>
        <literalValue>High</literalValue>
        <name>Update deal level</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>1M Opportunity Alert</fullName>
        <actions>
            <name>Update_deal_level</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>greaterOrEqual</operation>
            <value>1000000</value>
        </criteriaItems>
        <description>Alerts about won opportunity with amount greater than 1 million</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_Email_to_CEO_about_opportunity</name>
                <type>Alert</type>
            </actions>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Default Opportunity name</fullName>
        <actions>
            <name>Set_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Enforce opportunity naming convention</description>
        <formula>NOT( CONTAINS(Name, Account.Name) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Discount</fullName>
        <actions>
            <name>Send_Email_to_Sales_manager</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Call_to_client</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Proposal/Price Quote</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Close_Opportunity</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Rule 2</fullName>
        <actions>
            <name>Opportunity_name_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>NOT(CONTAINS( Name, Account.Name ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Call_to_client</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Call to client</subject>
    </tasks>
</Workflow>
