<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Active_to_True</fullName>
        <field>IsActive</field>
        <literalValue>1</literalValue>
        <name>Set Active to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Automatically Activate New Users</fullName>
        <actions>
            <name>Set_Active_to_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.IsActive</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Make sure that each new user is active so that the user can log in to Salesforce.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
